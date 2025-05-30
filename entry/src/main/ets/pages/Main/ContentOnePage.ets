import { AddMedicationRegimenDiaLog } from './DiaLog/AddMedicationRegimenDiaLog';
import { promptAction, router } from '@kit.ArkUI';
import { CalendarPage } from './CalendarPage/CalendarPage';
import { http } from '@kit.NetworkKit';
import { baseURL } from '../../constant/constant';
import { parseJSON, translateMedicineTime } from './ContentTwoPage';

interface planResult {
    medicine_name: string,
    medicine_timing?: number,
    amount: number,
    type: string,
    plan_time: string,
}

interface planResponse {
    code: number,
    message: string,
    result: planResult[]
}

@Preview
@Entry
@Component
export struct ContentOnePage {
    @State textValue: string = '';
    @State inputValue: string = '点击添加备注';
    @State planData: planResult[] = [];
    dialogController: CustomDialogController = new CustomDialogController({
        builder: AddMedicationRegimenDiaLog({
            textValue: $textValue,
            inputValue: $inputValue,
            cancel: this.onCancel,
            confirm: this.onConfirm
        }),
        autoCancel: true,
        alignment: DialogAlignment.Bottom,
        offset: { dx: 0, dy: -20 }
    });

    onCancel() {
        console.info('取消（删除）备注')
    };

    onConfirm() {
        console.info('确认保存备注: ', this.inputValue)
    };

    aboutToAppear(): void {
        this.getPlanList();
    };

    build() {
        Column({ space: 20 }) {
            Row() {
                CalendarPage()
            }.height('50%')

            if (this.planData.length > 0) {
                Scroll() {
                    Column({ space: '20.00vp' }) {
                        ForEach(this.planData, (item: planResult) => {
                            Row() {
                                Column({ space: '20.00vp' }) {
                                    Row() {
                                        Text(item.medicine_name + ' ' + item.amount + ' ' + item.type)
                                            .fontWeight(FontWeight.Bold)
                                    }

                                    Row() {
                                        Text(item.plan_time + ' ' + translateMedicineTime(item.medicine_timing))
                                    }

                                }


                                // Column({ space: '20.00vp' }) {
                                //     Text(item.medicine_name + ' ' + item.amount + ' ' + item.type)
                                //         .fontWeight(FontWeight.Bold)
                                //
                                //     Text(item.plan_time + ' ' + translateMedicineTime(item.medicine_timing))
                                //         .fontColor('#666666')
                                // }
                                // .alignSelf(ItemAlign.Start)

                                Blank().grayscale(1)

                                Button('打卡')
                                    .width('60')
                                    .height('30')
                                    .type(ButtonType.Normal)
                                    .onClick(() => {
                                        console.log('打卡: ', item.medicine_name)
                                    })
                                    .margin({ right: '20.00vp' })
                            }
                            .width('85%')
                            .justifyContent(FlexAlign.SpaceBetween)
                            .border({ width: 1, color: '#cccccc', radius: 8 })

                            // Column({ space: '20.00vp' }) {
                            //     Row() {
                            //         Text(item.medicine_name + ' ' + item.amount + ' ' + item.type)
                            //             .fontWeight(FontWeight.Bold)
                            //     }
                            //     .alignSelf(ItemAlign.Start)
                            //     .margin({ top: '20.00vp', left: '20.00vp' })
                            //
                            //     Row() {
                            //         Text(item.plan_time + ' ' + translateMedicineTime(item.medicine_timing))
                            //     }
                            //     .alignSelf(ItemAlign.Start)
                            //     .margin({ bottom: '20.00vp', left: '20.00vp' })
                            // }
                            // .width('80%')
                            // .border({ width: 1, color: '#cccccc', radius: 8 })
                            //
                            // Button('打卡')
                        })
                    }

                }.height('35%')

            } else {

                Column({ space: '20.00vp' }) {
                    Image($r('app.media.background'))
                        .width('80')
                        .height('80')
                    Text($r('app.string.NoNeedToPunchInToday'))
                    Button($r('app.string.AddMedicationRegimen'))
                        .width('70%')
                        .height('60')
                        .type(ButtonType.Normal)
                        .borderRadius('16')
                        .fontSize('16')
                        .onClick(() => {
                            router.pushUrl({ url: 'pages/Main/SubPages/MedicineCourse' })
                        })
                }
            }

            //
            // Image($r('app.media.background'))
            //     .width('80')
            //     .height('80')
            //
            // Text($r('app.string.NoNeedToPunchInToday'))
            //
            // Button($r('app.string.AddMedicationRegimen'))
            //     .width('70%')
            //     .height('60')
            //     .type(ButtonType.Normal)
            //     .borderRadius('16')
            //     .fontSize('16')
            //     .onClick(() => {
            //         router.pushUrl({ url: 'pages/Main/SubPages/MedicineCourse' })
            //     })
            //
            Button($r('app.string.WriteANote'))
                .width('50%')
                .height('60')
                .backgroundColor('#F4F7FF')
                .fontColor('#6599F2')
                .fontSize('16')
                .onClick(() => {
                    this.dialogController.open()
                    console.log('写备注点击事件')
                })
        }
        .width('100%')
        .height('100%')
    }

    private getPlanList() {
        let httpRequest = http.createHttp()
        let URL = baseURL + '/plan' + '/' + AppStorage.get('user_id')
        let promise = httpRequest.request(URL, {
            method: http.RequestMethod.GET,
            header: {
                'Content-Type': 'application/json',
                'token': AppStorage.get('token')
            }
        })
        promise.then((data: http.HttpResponse) => {
            let response = parseJSON<planResponse>(data.result.toString())
            if (response.code !== 0) {
                promptAction.showToast({ message: response.message });
                return;
            }
            this.planData = response.result
        })
    }
}

