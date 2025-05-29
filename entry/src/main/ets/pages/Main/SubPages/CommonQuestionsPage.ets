import { router } from '@kit.ArkUI'

const ITEM_WIDTH = '90%'
const ITEM_HEIGHT = '30.00vp'

@Component
@Entry
@Preview
struct CommonQuestionsPage {
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

            Column({ space: '20.00vp' }) {
                Row() {
                    Image($r('app.media.questions'))
                        .width('20.00vp')
                        .height('20.00vp')
                    Text('有没有铃声提醒? 闹钟提醒?')
                    Image($r('app.media.right_grey'))
                        .width('18.00vp')
                        .height('18.00vp')

                }
                .justifyContent(FlexAlign.SpaceBetween)
                .width(ITEM_WIDTH)
                .height(ITEM_HEIGHT)
                .onClick(() => {
                    router.pushUrl({ url: "pages/Main/SubPages/AnswerPages/AnswerOnePages" })
                })

                Row() {
                    Image($r('app.media.questions'))
                        .width('20.00vp')
                        .height('20.00vp')
                    Text('不小心误打卡, 如何取消? ')
                    Image($r('app.media.right_grey'))
                        .width('18.00vp')
                        .height('18.00vp')

                }
                .justifyContent(FlexAlign.SpaceBetween)
                .width(ITEM_WIDTH)
                .height(ITEM_HEIGHT)
                .onClick(() => {
                    router.pushUrl({ url: "pages/Main/SubPages/AnswerPages/AnswerTwoPages" })
                })

                Row() {
                    Image($r('app.media.questions'))
                        .width('20.00vp')
                        .height('20.00vp')
                    Text('为什么没有提醒了? ')
                    Image($r('app.media.right_grey'))
                        .width('18.00vp')
                        .height('18.00vp')

                }
                .justifyContent(FlexAlign.SpaceBetween)
                .width(ITEM_WIDTH)
                .height(ITEM_HEIGHT)
                .onClick(() => {
                    router.pushUrl({ url: "pages/Main/SubPages/AnswerPages/AnswerThreePages" })
                })


                Row() {
                    Image($r('app.media.questions'))
                        .width('20.00vp')
                        .height('20.00vp')
                    Text('关于本APP')
                    Image($r('app.media.right_grey'))
                        .width('18.00vp')
                        .height('18.00vp')

                }
                .justifyContent(FlexAlign.SpaceBetween)
                .width(ITEM_WIDTH)
                .height(ITEM_HEIGHT)
                .onClick(() => {
                    router.pushUrl({ url: "pages/Main/SubPages/AnswerPages/AnswerFourPages" })
                })

            }
            .margin({ top: '20.00vp' })
        }
        .width('100%').height('100%')
    }
}