import http from '@ohos.net.http';
import { promptAction, router } from '@kit.ArkUI';
import { baseHeader, baseURL } from '../../constant/constant';


/**
 * Login page
 */
interface userInfo {
    id: number;
    nickname: string;
    image: string;
    phone_num: string;
    password: string;
}

interface result {
    token: string;
    user: userInfo;
}

interface LoginResponse {
    code: number;
    message: string;
    result: result;
}

@Entry
@Component
struct LoginPage {
    @State account: string = '15056332824';
    @State password: string = '123456';

    build() {
        // container
        Column({ space: 10 }) {
            // logo
            Image($r('app.media.logo'))
                .width('80')
                .height('80')
                .margin({
                    top: '80',
                    bottom: '40'
                })
            // input
            TextInput({ placeholder: $r('app.string.account'), text: this.account, })
                .width('85%')
                .height('8%')
                .maxLength(11)
                .type(InputType.Number)
                .margin({
                    top: '60'
                })
                .onChange((value: string) => {
                    this.account = value
                })
            // input
            TextInput({ placeholder: $r('app.string.password'), text: this.password })
                .width('85%')
                .height('8%')
                .maxLength(8)
                .type(InputType.Password)
                .onChange((value: string) => {
                    this.password = value
                })

            // button
            Button($r('app.string.login'), { type: ButtonType.Capsule })
                .width('85%')
                .height('8%')
                .fontSize('18')
                .fontWeight(FontWeight.Medium)
                .backgroundColor($r('sys.color.brand'))
                .margin({
                    top: '48',
                    bottom: '12'
                })
                .onClick(() => {
                    let httpRequest = http.createHttp();
                    let URL = baseURL + '/user/login'
                    let promise = httpRequest.request(URL, {
                        method: http.RequestMethod.POST,
                        connectTimeout: 60000,
                        readTimeout: 60000,
                        header: baseHeader,
                        extraData: {
                            phone_num: this.account,
                            password: this.password
                        },
                        expectDataType: http.HttpDataType.OBJECT
                    });
                    promise.then((data: http.HttpResponse) => {
                        let result = data.result as LoginResponse;
                        if (result.code != 0) {
                            promptAction.showToast({ message: result.message });
                            return;
                        }
                        AppStorage.setOrCreate('token', result.result.token)
                        AppStorage.setOrCreate('nickname', result.result.user.nickname)
                        AppStorage.setOrCreate('user_id', result.result.user.id)
                        router.pushUrl({ url: 'pages/Main/MainPage' })
                    })
                })
        }
        .padding({
            left: '12vp',
            right: '12vp',
            bottom: '24vp'
        })
        .backgroundColor('#F1F3F5')
        .width('100%')
        .height('100%')
    }
}