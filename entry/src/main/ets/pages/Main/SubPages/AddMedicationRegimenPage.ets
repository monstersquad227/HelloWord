import { router } from '@kit.ArkUI';
import { JSON } from '@kit.ArkTS';

interface data {
    name: string;
    dailyNumber: number;
    everyTimeNumber: number;
    takeMedicationTime: string;
    selectTime: string;
    isInternal: boolean;
    isExternal: boolean;
}

@Component
@Entry
@Preview
struct AddMedicationRegimenPages {
    @State medicationName: string = '真菌王抑菌膏';
    @State dailyNumber: number = 0;
    @State everyTimeNumber: number = 0;
    @State selectTime: string = '';
    @State takeMedicationTime: string = '';
    @State isInternal: boolean = false;
    @State isExternal: boolean = false;

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

            Scroll() {
                Column({ space: 20 }) {
                    // 药物名称
                    Row() {
                        Column({ space: 10 }) {
                            Text('药物名称')
                                .padding(10)
                                .alignSelf(ItemAlign.Start)
                                .fontWeight(FontWeight.Bold)
                            TextInput({ placeholder: '请输入药物名称', text: this.medicationName })
                                .alignSelf(ItemAlign.Start)
                                .padding(10)
                                .border({ radius: 0 })
                                .backgroundColor(Color.White)
                                .onChange((value: string) => {
                                    this.medicationName = value
                                })

                        }
                    }
                    .width('90%')
                    .height('15%')
                    .border({ width: 1, color: '#cccccc', radius: '8' })

                    // 药物用量
                    Row() {
                        Column({ space: 10 }) {
                            Text('药物用量')
                                .padding(10)
                                .alignSelf(ItemAlign.Start)
                                .fontWeight(FontWeight.Bold)

                            Row() {
                                Text('每日')
                                Blank().width('60%')
                                Row() {
                                    TextInput({ text: this.dailyNumber.toString() }).type(InputType.Number)
                                        .width('20%')
                                        .onChange((value: string) => {
                                            this.dailyNumber = parseInt(value)
                                        })
                                    Blank().width(5)
                                    Text('次')
                                }
                            }
                            .padding(10)
                            .alignSelf(ItemAlign.Start)

                            Row() {
                                Text('每次')
                                Blank().width('60%')
                                Row() {
                                    TextInput({ text: this.everyTimeNumber.toString() }).type(InputType.Number)
                                        .width('20%')
                                        .onChange((value: string) => {
                                            this.everyTimeNumber = parseInt(value)
                                        })
                                    Blank().width(5)
                                    Text('粒')
                                }

                            }
                            .padding(10)
                            .alignSelf(ItemAlign.Start)
                        }
                    }
                    .width('90%')
                    .height('25%')
                    .border({ width: 1, color: '#cccccc', radius: '8' })

                    // 用药时间
                    Row() {
                        Column({ space: 10 }) {
                            Text('用药时间')
                                .padding(10)
                                .alignSelf(ItemAlign.Start)
                                .fontWeight(FontWeight.Bold)

                            Row() {
                                Text('时间')
                                    .fontSize(16)
                                    .width('auto')
                                    .alignSelf(ItemAlign.Center)
                                Blank().width('35%')
                                TimePicker({ format: TimePickerFormat.HOUR_MINUTE })
                                    .height(50)
                                    .width('50%')
                                    .border({ width: 1, color: '#cccccc', radius: 6 })
                                    .backgroundColor('#f5f5f5')
                                    .onChange((value) => {
                                        const hour = value.hour.toString().padStart(2, '0')
                                        const minute = value.minute.toString().padStart(2, '0')
                                        this.selectTime = `${hour}:${minute}`
                                    })
                            }
                            .padding({ left: 10, right: 10, bottom: 10 })
                        }
                    }
                    .width('90%')
                    .height('15%')
                    .border({ width: 1, color: '#cccccc', radius: '8' })

                    // 补充信息
                    Row() {
                        Column() {
                            Text('补充信息')
                                .padding(10)
                                .alignSelf(ItemAlign.Start)
                                .fontWeight(FontWeight.Bold)

                            Row({ space: 20 }) {
                                Text('用药方式')
                                Blank().width('15%')
                                Row() {
                                    Text('内服')
                                    Checkbox()
                                        .onChange((value: boolean) => {
                                            this.isInternal = value
                                        })
                                }

                                Row() {
                                    Text('外服')
                                    Checkbox()
                                        .onChange((value: boolean) => {
                                            this.isExternal = value
                                        })
                                }
                            }
                            .padding(10)

                            Row() {
                                Text('用药时机')
                                Blank().width('35%')
                                Select([
                                    { value: '饭后用药' },
                                    { value: '饭前用药' },
                                    { value: '随餐用药' },
                                    { value: '睡前用药' },
                                    { value: '不限' }
                                ])
                                    .value(this.takeMedicationTime)
                                    .width('40%')
                            }
                            .alignSelf(ItemAlign.Start)
                            .padding(10)
                        }
                    }
                    .width("90%")
                    .height('20%')
                    .border({ width: 1, color: '#cccccc', radius: '8' })


                    Button('保存')
                        .width('90%')
                        .borderRadius(8)
                        .margin({ bottom: 40 })
                        .onClick(() => {
                            const body: data = {
                                name: this.medicationName,
                                dailyNumber: this.dailyNumber,
                                everyTimeNumber: this.everyTimeNumber,
                                takeMedicationTime: this.takeMedicationTime,
                                selectTime: this.selectTime,
                                isInternal: this.isInternal,
                                isExternal: this.isExternal
                            }
                            AlertDialog.show({
                                title: '',
                                message: JSON.stringify(body)
                            })
                            router.back()
                        })

                }

            }.height('100%').width('100%')

        }
        .width('100%')

        // .height('100%')
    }
}