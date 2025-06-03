import { router } from '@kit.ArkUI';

@Entry
@Component
struct Index {
    // @State message: string = 'Hello World';

    aboutToAppear(): void {
        setTimeout(() => {
            const token = AppStorage.get<number>('aProp');
            if (token === 47) {
                // AlertDialog.show({ title: 'picture token', message: token?.toString() })
                router.replaceUrl({ url: "pages/Main/MainPage" })
            } else {
                // AlertDialog.show({ title: 'picture token', message: token?.toString() })
                router.replaceUrl({ url: "pages/Login/LoginPage" })
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