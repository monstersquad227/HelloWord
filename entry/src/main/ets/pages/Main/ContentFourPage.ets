import { router } from '@kit.ArkUI'

@Component
export struct ContentFourPage {
    build() {
        Column({ space: 20 }) {
            Image($r('app.media.circle'))
                .width('80')
                .height('80')
                .margin({
                    top: 50
                })

            Text($r('app.string.UserID'))

            Row() {
                Column({ space: 8 }) {
                    Image($r('app.media.record'))
                        .width('32')
                        .height('32')
                    Text($r('app.string.FAQ'))
                }
                .width('33.33%')

                Column({ space: 8 }) {
                    Image($r('app.media.edit'))
                        .width('32')
                        .height('32')
                    Text($r('app.string.PersonalInformation'))
                }
                .width('33.33%')
                .onClick(() => {
                    router.pushUrl({ url: 'pages/Main/SubPages/PersonalInformationPage'})
                })

                Column({ space: 8 }) {
                    Image($r('app.media.circle'))
                        .width('32')
                        .height('32')
                    Text($r('app.string.Feedback'))
                }
                .width('33.33%')
                .onClick(() => {
                    router.pushUrl({ url: 'pages/Main/SubPages/FeatureFeedbackPage' })
                })
            }
            .width('90%')
            .height('13%')
            .border({ width: 1, color: '#cccccc', radius: '8' })
            .backgroundColor('#f9f9f9')

            Row() {
                Text($r('app.string.SupportAuthor'))
                Image($r('app.media.right_grey'))
                    .width('16')
                    .height('16')
            }
            .justifyContent(FlexAlign.SpaceBetween)
            .padding('10')
            .width('90%')
            .height('6%')
            .border({ width: 1, color: '#cccccc', radius: '8' })
            .backgroundColor('#f9f9f9')
            .onClick(() => {
                router.pushUrl({ url: 'pages/Main/SubPages/SupportAuthorPage' })
            })
        }
        .width('100%')
        .height('100%')
        .backgroundColor($r('app.color.page_background'))
    }
}