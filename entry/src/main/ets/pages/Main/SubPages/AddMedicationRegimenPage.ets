import { router } from '@kit.ArkUI'

@Component
@Entry
@Preview
struct AddMedicationRegimenPages {
    build() {
        Column({ space: 10 }) {
            // 返回图标
            Row() {
                Column() {
                    Image($r('app.media.right_grey'))
                        .width('16')
                        .height('16')
                        .onClick(() => {
                            router.back()
                        })
                }
                .alignItems(HorizontalAlign.Start)
            }

            // 药物名称
            Row() {
                Column({ space: 5 }) {
                    Text('药物名称')
                        .margin({ left: 10 })
                    TextInput()
                }
                .alignItems(HorizontalAlign.Start)
            }
            .width('90%')
            .height('10%')
            .border({ width: 1, color: '#cccccc', radius: '8' })

            // 药物用量
            Row() {
                Column({ space: 5 }) {
                    Text('药物用量')
                        .margin({ left: 10 })

                    Row() {
                        Text('每日')
                        TextInput().type(InputType.Number)
                            .width('10%')
                        Text('次')
                    }

                    Row() {
                        Text('每次')
                        TextInput().type(InputType.Number)
                            .width('10%')
                        Text('粒')
                    }
                }
            }
            .width('90%')
            .height('20%')
            .border({ width: 1, color: '#cccccc', radius: '8' })

            // 用药时间
            Row() {
                Column() {
                    Text('用药时间')
                    Row() {
                        Text('时间')
                            .width('50%')
                        TimePicker()
                            .width('50%')
                            .height('40')
                    }
                }
            }
            .width('90%')
            .height('10%')
            .border({ width: 1, color: '#cccccc', radius: '8' })

            // 补充信息
            Row() {
                Column() {
                    Text('补充信息')
                        .align(Alignment.Start)

                    Row({ space: 20 }) {
                        Text('用药方式')
                        Text('内服')
                        Checkbox()
                        Text('外服')
                        Checkbox()
                    }

                    Row({ space: 30 }) {
                        Text('用药时机')
                        Select([
                            { value: '饭后用药' },
                            { value: '饭前用药' },
                            { value: '随餐用药' },
                            { value: '睡前用药' },
                            { value: '不限' }
                        ])
                    }
                }
            }
            .width("90%")
            .height('20%')
            .border({ width: 1, color: '#cccccc', radius: '8' })
        }
        .width('100%')
        .height('100%')
    }
}