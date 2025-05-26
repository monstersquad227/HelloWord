import { router } from '@kit.ArkUI'

@Component
@Preview
@Entry
struct SupportAuthorPage {
    @State payNumber: number = 0

    build() {
        Column() {
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
                Text('为了不影响操作，所有广告集中在这边\n在这里，您可以主动点击广告支持作者，也可以直接打赏。您的支持是我们维护此项目的动力')
                    .margin({ top: '50%', left: '20', right: '20' })
                TextInput({ placeholder: '请出入打赏金额', text: this.payNumber.toString() })
                    .type(InputType.Number)
                    .width('90%')
                    .onChange((value: string) => {
                        const num = parseInt(value)
                        if (!isNaN(num)) {
                            this.payNumber = num
                        } else {
                            this.payNumber = 0
                        }
                    })


                Button('打赏')
                    .width('90%')
                    .onClick(() => {
                        AlertDialog.show({
                            title: '',
                            message: '您已经完整打赏: ' + this.payNumber + '元',
                            confirm: {
                                value: '确定',
                                action: () => {
                                    console.log('用户点击了确定')
                                }
                            }
                        })
                    })
                Button('看广告')
                    .backgroundColor(Color.Green)
                    .width('90%')
                    .onClick(() => {
                        AlertDialog.show({
                            title: '提示',
                            message: '你真的要看广告吗？',
                            confirm: {
                                value: '确定',
                                action: () => {
                                    console.log('用户点击了确定');
                                },
                            },
                        })
                    })
            }
            .width('100%')
            .height('100%')
        }
    }
}