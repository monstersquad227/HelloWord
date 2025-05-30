import { promptAction, router } from '@kit.ArkUI';
import http from '@ohos.net.http';
import { baseURL } from '../../constant/constant';

interface MedicineCourse {
    medicine_name: string
    medicine_image: string
    medicine_type: number
    medicine_timing?: number
    course_start_time: string
    frequency: number
}

interface CourseResponse {
    code: number
    message: string
    result: MedicineCourse[]
}

@Preview
@Entry
@Component
export struct ContentTwoPage {
    @State courseData: MedicineCourse[] = [];
    @State isRefreshing: boolean = false;

    aboutToAppear(): void {
        this.getCourseList()
    }

    build() {
        Column({ space: 20 }) {
            Refresh({
                refreshing: this.isRefreshing,
            }) {
                if (this.courseData.length > 0) {
                    Scroll() {
                        Column() {
                            ForEach(this.courseData, (item: MedicineCourse) => {
                                Row() {
                                    Column({ space: 20 }) {
                                        Text(item.medicine_name)
                                            .margin({ left: '10.00vp' })
                                            .alignSelf(ItemAlign.Start)
                                            .fontWeight(FontWeight.Bold)

                                        Row() {
                                            Text(
                                                '每日 ' + item.frequency + ' 次, ' +
                                                translateMedicineTime(item.medicine_timing)
                                            )
                                                .width('70%')
                                            Blank().width('19%')
                                            Text(translateType(item.medicine_type))
                                                .width('11%')
                                        }
                                        .margin({ left: '10.00vp', right: '10.00vp' })

                                        Row() {
                                            Text(splitDate(item.course_start_time) + ' 开始')
                                        }
                                        .alignSelf(ItemAlign.Start)
                                        .margin({ left: '10.00vp', right: '10.00vp' })
                                    }
                                    .margin({ top: '10.00vp', bottom: '10.00vp' })
                                }
                                .width('90%')
                                .margin({ top: '10.00vp' })
                                .border({ width: 1, color: '#cccccc', radius: '8' })
                            })
                        }
                    }
                    .width('100%')
                    .height('88%')
                } else {
                    Text('暂无数据')
                        .margin({ top: '100.00vp' })
                        .fontWeight(FontWeight.Bold)
                }
            }
            .onStateChange(() => {
                this.isRefreshing = true
                this.getCourseList()
                this.isRefreshing = false
            })


            Button($r('app.string.AddMedicationRegimen'))
                .width('90%')
                .height('60.00vp')
                .type(ButtonType.Normal)
                .borderRadius('16')
                .fontSize('16')
                .onClick(() => {
                    router.pushUrl({ url: 'pages/Main/SubPages/MedicineCourse' })
                })
        }
        .width('100%')
        .height('100%')
    }

    private getCourseList() {
        let httpRequest = http.createHttp();
        let URL = baseURL + '/course'
        let promise = httpRequest.request(URL, {
            method: http.RequestMethod.GET,
            connectTimeout: 3000,
            readTimeout: 3000,
            header: {
                'Content-Type': 'application/json',
                'token': AppStorage.get('token')
            },
        });
        promise.then((data: http.HttpResponse) => {
            let response = parseJSON<CourseResponse>(data.result.toString())
            // AlertDialog.show({ title: '课程列表', message: response.result.length.toString() })
            if (response.code !== 0) {
                promptAction.showToast({ message: response.message });
                return;
            }
            this.courseData = response.result
        })
    }
}

export function parseJSON<T>(jsonStr: string): T {
    return JSON.parse(jsonStr) as T;
}

export function translateType(type: number): string {
    switch (type) {
        case 1:
            return '外服';
        default:
            return '内服';
    }
}

export function translateMedicineTime(medicineTime: number): string {
    switch (medicineTime) {
        case 1:
            return '饭前用药';
        case 2:
            return '饭后用药';
        case 3:
            return '随餐用药';
        case 4:
            return '睡前用药';
        default:
            return '不限';
    }
}

function splitDate(date: string): string {
    let sDate = date.split(' ');
    if (sDate.length !== 2) {
        return '0000-00-00'
    }
    return sDate[0];
}
