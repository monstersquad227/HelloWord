import { router } from '@kit.ArkUI'

@Entry
@Component
struct Index {
    // @State message: string = 'Hello World';

    aboutToAppear(): void {
        setTimeout(() => {
            // AlertDialog.show({ title: 'aProb', message: AppStorage.get('token') })
            let token = AppStorage.get('token') ?? 'default'
            if (token === 'default') {
                router.replaceUrl({ url: "pages/Login/LoginPage" })
            } else {
                router.replaceUrl({ url: "pages/Main/MainPage" })
            }
        }, 200)
    }

    build() {
        Column() {
            Text('Loading...')
                .fontSize(20)
        }
        .width('100%')
        .height('100%')
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor('#FFFFFF')
    }
}