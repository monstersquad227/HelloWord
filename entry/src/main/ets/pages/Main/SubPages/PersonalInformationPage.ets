import { CustomContentDialog, promptAction, router } from '@kit.ArkUI';
import http from '@ohos.net.http';
import { baseURL } from '../../../constant/constant';
import { parseJSON } from '../ContentTwoPage';

// 尺寸常量
const ITEM_HEIGHT = '30.00vp'
const ITEM_WIDTH = '80%'

interface UpdateResponse {
    code: number,
    message: string,
    result: number
}

@Component
struct RowItem {
    @State label: string = '';
    @Link value: string | Resource;
    @State inputText: string = '';
    @State type: string = '';
    dialogController: CustomDialogController = new CustomDialogController({
        builder: CustomContentDialog({
            primaryTitle: '修改' + this.label,
            contentBuilder: () => {
                this.buildContent();
            },
            buttons: [
                {
                    value: '确定',
                    buttonStyle: ButtonStyleMode.TEXTUAL,
                    action: () => {
                        if (this.type === 'nickname') {
                            let httpRequest = http.createHttp()
                            let URL = baseURL + '/user/' + AppStorage.get('user_id') + '/nickname'
                            let promise = httpRequest.request(URL, {
                                method: http.RequestMethod.PUT,
                                header: {
                                    'Content-Type': 'application/json',
                                    'token': AppStorage.get('token')
                                },
                                extraData: {
                                    nickname: this.inputText
                                },
                                expectDataType: http.HttpDataType.OBJECT
                            })
                            promptAction.showToast({ message: this.inputText })
                            promise.then((data: http.HttpResponse) => {
                                let response = parseJSON<UpdateResponse>(data.result.toString())
                                if (response.code !== 0) {
                                    promptAction.showToast({ message: response.message });
                                    return;
                                }
                                AppStorage.setOrCreate('nickname', this.inputText)
                                this.value = this.inputText
                            })
                        } else if (this.type === 'phone') {
                            let httpRequest = http.createHttp()
                            let URL = baseURL + '/user/' + AppStorage.get('user_id') + '/phone'
                            let promise = httpRequest.request(URL, {
                                method: http.RequestMethod.PUT,
                                header: {
                                    'Content-Type': 'application/json',
                                    'token': AppStorage.get('token')
                                },
                                extraData: {
                                    phone_num: this.inputText
                                },
                                expectDataType: http.HttpDataType.OBJECT
                            })
                            promise.then((data: http.HttpResponse) => {
                                let response = parseJSON<UpdateResponse>(data.result.toString())
                                if (response.code !== 0 || data.responseCode !== 200) {
                                    promptAction.showToast({ message: response.message });
                                    return;
                                }
                                AppStorage.setOrCreate('phone_num', this.inputText)
                                this.value = this.inputText
                            })
                        }
                    }
                },
                {
                    value: '取消',
                    buttonStyle: ButtonStyleMode.TEXTUAL,
                    role: ButtonRole.ERROR
                }
            ],
        }),
    });

    build() {
        Row() {
            Text(this.label).height(ITEM_HEIGHT)
            Blank().flexGrow(1)
            Text(this.value)
                .onClick(() => {
                    this.dialogController.open()
                })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width(ITEM_WIDTH)
        .height(ITEM_HEIGHT)
    }

    @Builder
    buildContent(): void {
        Column() {
            TextInput({ text: this.inputText, placeholder: this.value }).onChange((value: string) => {
                this.inputText = value
            })
        }
        .width('100%')
    }
}

@Component
struct RowImageItem {
    @State label: string = ''
    @State imageRes: Resource = $r('app.media.circle')

    build() {
        Row() {
            Text(this.label).height(ITEM_HEIGHT)
            Blank().flexGrow(1)
            Image(this.imageRes)
                .width(ITEM_HEIGHT)
                .height(ITEM_HEIGHT)
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .width(ITEM_WIDTH)
        .height(ITEM_HEIGHT)
    }
}

@Preview
@Entry
@Component
struct PersonalInformationPage {
    @StorageProp('nickname') nickname: string | undefined = AppStorage.get('nickname');
    @StorageProp('phone') phone: string | undefined = AppStorage.get('phone_num');

    build() {
        Column() {
            // 返回按钮
            Image($r('app.media.right_grey'))
                .width(16)
                .height(16)
                .rotate({ angle: 180 })
                .onClick(() => {
                    router.back()
                })
                .alignSelf(ItemAlign.Start)
                .margin({ left: 20, top: 20 })

            Column({ space: '20.00vp' }) {
                // 用户信息展示
                RowImageItem({ label: '头像', imageRes: $r('app.media.circle') })
                RowItem({ label: '昵称', value: this.nickname, type: 'nickname' })
                RowItem({ label: '手机号', value: this.phone, type: 'phone' })
            }
            .margin({ top: '20.00vp' })
        }
        .width('100%')
        .height('100%')
    }
}
