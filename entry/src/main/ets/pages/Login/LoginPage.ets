import http from '@ohos.net.http';
import { prompt, router } from '@kit.ArkUI';


interface UserInfo {
    id: number;
    nickname: string;
    image: string;
    phone_num: string;
    password: string;
    created_at: string;
    updated_at: string;
}

interface LoginResult {
    token: string;
    user: UserInfo;
}

interface ApiResponse {
    code: number;
    message: string;
    result: LoginResult;
}

/**
 * Login page
 */
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
            // input
            TextInput({ placeholder: $r('app.string.password'), text: this.password })
                .width('85%')
                .height('8%')
                .maxLength(8)
                .type(InputType.Password)

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
                    const httpRequest = http.createHttp();
                    httpRequest.request(
                        "http://10.11.11.56:8080/medicine/user/login",
                        {
                            method: http.RequestMethod.POST,
                            header: {
                                "Content-Type": "application/json"
                            },
                            extraData: {
                                phone_num: this.account,
                                password: this.password
                            },
                            readTimeout: 6000,
                            connectTimeout: 6000
                        },
                        (err, data) => {
                            if (err) {
                                AlertDialog.show({ title: '失败', message: JSON.stringify(err) });
                                return;
                            }
                            let parsed: ApiResponse;
                            parsed = JSON.parse(data.result as string) as ApiResponse;
                            prompt.showToast({ message: '登录成功: ' + parsed.result.user.nickname });
                            AppStorage.set("nickname", parsed.result.user.nickname)
                            router.pushUrl({ url: 'pages/Main/MainPage' })
                            // JSON.stringify(data)
                            // AlertDialog.show({ title: '成功', message: data.result.token });
                        }
                    )
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