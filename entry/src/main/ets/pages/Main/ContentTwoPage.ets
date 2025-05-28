import { promptAction, router } from '@kit.ArkUI';
import http from '@ohos.net.http';
import { baseURL } from '../../constant/constant';

interface resultStruct {
    id: number,
    medicine_name: string,
    medicine_image: string,
    medicine_type: number,
    course_start_time: string,
    created_at: string,
    updated_at: string
}

interface courseListResponse {
    code: number;
    message: string;
    result: resultStruct[]
}

@Preview
@Entry
@Component
export struct ContentTwoPage {
    @State courseData: resultStruct[] = [];

    // onPageShow() {
    //     // this.getCourseList()
    // }

    build() {
        Column({ space: 20 }) {
            ForEach(this.courseData, (item: resultStruct) => {
                Text(item.medicine_name)
            })
            // ForEach(this.courseData, (item: resultStruct) => {
            //     Row() {
            //         Column({ space: 20 }) {
            //             Text(item.medicine_name)
            //                 .margin({ left: '10.00vp' })
            //                 .alignSelf(ItemAlign.Start)
            //                 .fontWeight(FontWeight.Bold)
            //         }
            //     }
            //     .width('90%')
            //     .margin({ top: '10.00vp' })
            //     .border({ width: 1, color: '#cccccc', radius: '8' })
            // })
            // Row() {
            //     Column({ space: 20 }) {
            //         Text('真菌王抑菌膏')
            //             .margin({ left: '10.00vp' })
            //             .alignSelf(ItemAlign.Start)
            //             .fontWeight(FontWeight.Bold)
            //
            //         Row() {
            //             Text('每日一次, 饭后用药')
            //                 .width('70%')
            //             Blank().width('19%')
            //             Text('内服')
            //                 .width('11%')
            //         }
            //         .margin({ left: '10.00vp', right: '10.00vp' })
            //
            //         Row() {
            //             Text('2025-05-20 开始')
            //         }
            //         .alignSelf(ItemAlign.Start)
            //         .margin({ left: '10.00vp', right: '10.00vp' })
            //     }
            //     .margin({ top: '10.00vp', bottom: '10.00vp' })
            // }
            // .width('90%')
            // .margin({ top: '10.00vp' })
            // .border({ width: 1, color: '#cccccc', radius: '8' })

            Button($r('app.string.AddMedicationRegimen'))
                .width('90%')
                .height('60')
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
                'token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2NvdW50IjoiMTUwNTYzMzI4MjQiLCJjcmVhdGVfYXQiOiIyMDI1LTA1LTI4VDE2OjEyOjE4LjI3NjI5MyswODowMCIsImV4cCI6MTc0ODQ2MzEzOH0.53EwIpF5GmcFN3P75b97pumzSv3-TkIahQNRKnZvtKc'
            },
        });
        promise.then((data: http.HttpResponse) => {
            let resp = data.result as courseListResponse;
            if (resp.code != 0) {
                promptAction.showToast({ message: resp.message });
                return;
            }
            AlertDialog.show({ title: 'courseList', message: JSON.stringify(resp) })
            this.courseData = resp.result
        })
    }
}