import { promptAction, router } from '@kit.ArkUI';
import { http } from '@kit.NetworkKit';
import { baseURL } from '../../../constant/constant';

interface data {
    user_id: number; // 1
    medicine_name: string; // 厄贝沙坦氢氟噻嗪片
    medicine_image: string; // ''
    medicine_type: number; // 0 外用； 1 内用
    medicine_timing: number; // 0 不限; 1 饭前用药; 2 饭后用药; 3 随餐用药; 4 睡前用药;
    course_start_time: string; // 开始日期  2025-05-27 19:00:00
    status: number; //方案状态 0 生效， 废弃； 创建时激活
    amount: number; // 用药数量
    type: string; // 剂量单位
    plan_time: string;
    frequency: number
}

interface courseAddResponse {
    code: number,
    message: string,
    result: number
}

@Component
@Entry
@Preview
struct MedicineCourse {
    @State selectedDate: Date = new Date()
    @State medicineName: string = '';
    @State medicineType: number = 0;
    @State medicineTiming: number = 0;
    @State courseStartTime: string = '';
    @State amount: number = 0;
    @State type: string = '粒';
    @State frequency: number = 0;

    build() {
        Column({ space: 20 }) {
            // 返回图标
            Image($r('app.media.right_grey'))
                .width(16)
                .height(16)
                .rotate({ angle: 180 })
                .onClick(() => {
                    router.back()
                })
                .alignSelf(ItemAlign.Start)
                .margin({ left: 20, top: 20, })

            Column({ space: 20 }) {
                // 药物名称
                Row() {
                    Column({ space: 20 }) {
                        Text('药物名称')
                            .margin({ left: '10.00vp' })
                            .alignSelf(ItemAlign.Start)
                            .fontWeight(FontWeight.Bold)

                        TextInput({ placeholder: '请输入药物名称', text: this.medicineName })
                            .alignSelf(ItemAlign.Start)
                            .height(30)
                            .border({ radius: 0 })
                            .backgroundColor(Color.White)
                            .onChange((value: string) => {
                                this.medicineName = value
                            })
                            .padding({
                                top: '0.00vp',
                                right: '10.00vp',
                                bottom: '0.00vp',
                                left: '10.00vp'
                            })
                    }
                    .margin({ top: '20.00vp', bottom: '20.00vp' })
                }
                .width('90%')
                // .height('13%')
                .border({ width: 1, color: '#cccccc', radius: '8' })

                // 药物用量
                Row() {
                    Column({ space: 20 }) {
                        Text('药物用量')
                            .margin({ left: '10.00vp' })
                            .alignSelf(ItemAlign.Start)
                            .fontWeight(FontWeight.Bold)

                        Row() {
                            Text('每日')
                                .width('15%')
                            Blank().width('50%')
                            Row() {
                                TextInput()
                                    .type(InputType.Number)
                                    .width('50%')
                                    .fontSize(13)
                                    .borderRadius(8)
                                    .onChange((value: string) => {
                                        this.frequency = parseInt(value)
                                    })
                                Blank().width('5%')
                                Text('次')
                            }
                            .justifyContent(FlexAlign.SpaceBetween)
                            .height(40)
                            .width('35%')
                        }
                        .margin({ left: '10.00vp', right: '10.00vp' })


                        Row() {
                            Text('每次')
                                .width('15%')
                            Blank().width('50%')
                            Row() {
                                TextInput()
                                    .type(InputType.Number)
                                    .fontSize(13)
                                    .width('50%')
                                    .borderRadius(8)
                                    .onChange((value: string) => {
                                        this.amount = parseInt(value)
                                    })
                                Blank().width('5%')
                                TextInput({ text: this.type })
                                    .borderRadius(8)
                                    .onChange((value: string) => {
                                        this.type = value
                                    })
                                    .width('45%')
                            }
                            .justifyContent(FlexAlign.SpaceBetween)
                            .height(40)
                            .width('35%')
                        }
                        .margin({ left: '10.00vp', right: '10.00vp' })
                    }
                    .margin({ top: '20.00vp', bottom: '20.00vp' })
                }
                .width('90%')
                .border({ width: 1, color: '#cccccc', radius: '8' })

                // 用药时间
                Row() {
                    Column({ space: 20 }) {
                        Text('用药时间')
                            .margin({ left: '10.00vp' })
                            .alignSelf(ItemAlign.Start)
                            .fontWeight(FontWeight.Bold)

                        Row() {
                            Text('时间')
                                .width('15%')
                            Blank().width('35%')
                            Button(this.courseStartTime === '' ? '选择时间' : this.courseStartTime)
                                .width('50%')
                                .fontSize(13)
                                .fontColor(Color.Black)
                                .type(ButtonType.Normal)
                                .borderRadius(8)
                                .backgroundColor('#F2F2F2')
                                .onClick(() => {
                                    this.getUIContext().showDatePickerDialog({
                                        start: new Date("2000-1-1"),
                                        end: new Date("2100-12-31"),
                                        showTime: true,
                                        useMilitaryTime: true,
                                        selected: this.selectedDate,
                                        onDateAccept: ((value: Date) => {
                                            this.selectedDate = value
                                            this.courseStartTime = this.formatDateTime(this.selectedDate)
                                        }),
                                        onDateChange: ((value: Date) => {
                                            this.selectedDate = value
                                            this.courseStartTime = this.formatDateTime(this.selectedDate)
                                        })
                                    })
                                })
                        }.margin({ left: '10.00vp', right: '10.00vp' })
                    }
                    .margin({ top: '20.00vp', bottom: '20.00vp' })
                }
                .width('90%')
                .border({ width: 1, color: '#cccccc', radius: '8' })

                // 补充信息
                Row() {
                    Column({ space: 20 }) {
                        Text('补充信息')
                            .margin({ left: '10.00vp' })
                            .alignSelf(ItemAlign.Start)
                            .fontWeight(FontWeight.Bold)

                        Row() {
                            Text('用药方式').width('25%')
                            // 空格填充
                            Blank().width('30%')
                            // 内服
                            Row() {
                                Text('内服')
                                Radio({ group: 'medicineType', value: '0', })
                                    .onChange((value) => {
                                        if (value === true) {
                                            this.medicineType = 0
                                        }
                                    })
                            }
                            .justifyContent(FlexAlign.SpaceBetween)
                            .width('20%')

                            // 空格填充
                            Blank().width('5%')
                            // 外服
                            Row() {
                                Text('外服')
                                Radio({ group: 'medicineType', value: '1' })
                                    .onChange((value) => {
                                        if (value === true) {
                                            this.medicineType = 1
                                        }
                                    })
                            }
                            .justifyContent(FlexAlign.SpaceBetween)
                            .width('20%')
                        }
                        .margin({ left: '10.00vp', right: '10.00vp' })

                        // 用药时机
                        Row() {
                            Text('用药时机')
                                .width('25%')
                            Blank().width('35%')
                            Select([
                                { value: '不限' },
                                { value: '饭前用药' },
                                { value: '饭后用药' },
                                { value: '随餐用药' },
                                { value: '睡前用药' }
                            ])
                                .onSelect((index: number) => {
                                    this.medicineTiming = index
                                })
                                .width('40%')
                                .borderRadius(8)
                        }
                        .margin({ left: '10.00vp', right: '10.00vp' })
                    }
                    .margin({ top: '20.00vp', bottom: '20.00vp' })
                }
                .width("90%")
                // .height('22%')
                .border({ width: 1, color: '#cccccc', radius: '8' })

                Button('保存')
                    .width('90%')
                    .borderRadius(8)
                    .margin({ bottom: 40 })
                    .onClick(() => {
                        const body: data = {
                            user_id: Number(AppStorage.get('user_id')),
                            medicine_name: this.medicineName,
                            medicine_image: '',
                            medicine_type: this.medicineType,
                            medicine_timing: this.medicineTiming,
                            course_start_time: this.courseStartTime,
                            status: 0,
                            amount: this.amount,
                            type: this.type,
                            plan_time: this.generateTime(this.courseStartTime),
                            frequency: this.frequency
                        }
                        let httpRequest = http.createHttp();
                        let URL = baseURL + '/course'
                        let promise = httpRequest.request(URL, {
                            method: http.RequestMethod.POST,
                            connectTimeout: 6000,
                            readTimeout: 6000,
                            header: {
                                'Content-Type': 'application/json',
                                'token': AppStorage.get('token')
                            },
                            extraData: body,
                            expectDataType: http.HttpDataType.OBJECT
                        });
                        promise.then((res: http.HttpResponse) => {
                            let result = res.result as courseAddResponse
                            if (result.code !== 0) {
                                promptAction.showToast({ message: result.message })
                                return;
                            } else {
                                promptAction.showToast({ message: '添加成功' })
                                router.back()
                            }
                        })

                    })
            }
            .width('100%').height('100%')
        }
        .width('100%')
    }

    private formatDateTime(date: Date): string {
        const year = date.getFullYear();
        const month = (date.getMonth() + 1).toString().padStart(2, '0'); // 月份补零
        const day = date.getDate().toString().padStart(2, '0'); // 日期补零
        const hours = date.getHours().toString().padStart(2, '0'); // 小时补零
        const minutes = date.getMinutes().toString().padStart(2, '0'); // 分钟补零
        const seconds = date.getSeconds().toString().padStart(2, '0'); // 秒补零

        return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
    }

    private generateTime(date: string): string {
        let time = date.split(' ')
        if (time.length !== 2) {
            return '';
        }
        let timePart = time[1];
        let timeParts = timePart.split(':');
        if (timeParts.length < 2) {
            return '';
        }
        return `${timeParts[0]}:${timeParts[1]}`;
    }
}
