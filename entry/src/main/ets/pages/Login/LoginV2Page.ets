import { loginComponentManager, LoginWithHuaweiIDButton } from '@kit.AccountKit';
import { promptAction } from '@kit.ArkUI';
import { common, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
@Preview
export struct LoginV2 {
    controller: loginComponentManager.LoginWithHuaweiIDButtonController =
        new loginComponentManager.LoginWithHuaweiIDButtonController()
            .setAgreementStatus(loginComponentManager.AgreementStatus.NOT_ACCEPTED)
            .onClickLoginWithHuaweiIDButton((error, response) => {
                if (error) {
                    AlertDialog.show({ title: 'login Error', message: JSON.stringify(error) })
                    promptAction.showToast({ message: '请阅读并同意隐私协议' })
                } else {
                    promptAction.showToast({ message: JSON.stringify(response) })
                }
                // promptAction.showToast({ message: response.unionID })

            })
            .onClickEvent((error, clickEvent) => {
                if (error) {
                    promptAction.showToast({ message: 'onClickEvent error' })
                }
                if (clickEvent) {
                    promptAction.showToast({ message: clickEvent })
                }
            })
    privacyText: loginComponentManager.PrivacyText[] = [{
        text: '已阅读并同意',
        type: loginComponentManager.TextType.PLAIN_TEXT
    }, {
        text: '《用户服务协议》',
        tag: '用户服务协议',
        type: loginComponentManager.TextType.RICH_TEXT
    }, {
        text: '《隐私协议》',
        tag: '隐私协议',
        type: loginComponentManager.TextType.RICH_TEXT
    }, {
        text: '和',
        type: loginComponentManager.TextType.PLAIN_TEXT
    }, {
        text: '《华为账号用户认证协议》',
        tag: '华为账号用户认证协议',
        type: loginComponentManager.TextType.RICH_TEXT
    }];

    build() {
        Column() {
            Column({ space: '30.00vp' }) {
                Image($r('app.media.meditime'))
                    .height('80.00vp')
                    .width('80.00vp')
                    .margin({ top: '100.00vp' })

                Text('按时吃药')

                LoginWithHuaweiIDButton({
                    params: {
                        style: loginComponentManager.Style.BUTTON_RED,
                        extraStyle: {
                            buttonStyle: new loginComponentManager.ButtonStyle().loadingStyle({
                                show: true
                            })
                        },
                        borderRadius: 24,
                        loginType: loginComponentManager.LoginType.QUICK_LOGIN,
                        supportDarkMode: true,
                        verifyPhoneNumber: true
                    },
                    controller: this.controller
                })
                    .height(40)
                    .width('100%')
                    .margin({ top: '56.00vp' })
            }

            Row() {
                Row() {
                    Checkbox({ name: 'privacyCheckbox', group: 'privacyCheckboxGroup' })
                        .width(24)
                        .height(24)
                        .focusable(true)
                        .focusOnTouch(true)
                        .margin({ top: 0 })
                        .onChange((value: boolean) => {
                            if (value) {
                                this.controller.setAgreementStatus(loginComponentManager.AgreementStatus.ACCEPTED)
                            } else {
                                this.controller.setAgreementStatus(loginComponentManager.AgreementStatus.NOT_ACCEPTED)
                            }
                        })
                }

                Row() {
                    Text() {
                        ForEach(this.privacyText, (item: loginComponentManager.PrivacyText) => {
                            if (item?.type === loginComponentManager.TextType.PLAIN_TEXT && item?.text) {
                                Span(item?.text)
                                    .fontColor($r('sys.color.ohos_id_color_text_secondary'))
                                    .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
                                    .fontWeight(FontWeight.Regular)
                                    .fontSize($r('sys.float.ohos_id_text_size_body3'))
                            } else if (item?.type === loginComponentManager.TextType.RICH_TEXT && item?.text) {
                                Span(item?.text)
                                    .fontColor($r('sys.color.ohos_id_color_text_primary_activated'))
                                    .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
                                    .fontWeight(FontWeight.Medium)
                                    .fontSize($r('sys.float.ohos_id_text_size_body3'))
                                    .focusable(true)
                                    .focusOnTouch(true)
                                    .onClick(() => {
                                        if (item.tag === '华为账号用户认证协议') {
                                            this.openURL('')
                                            // AlertDialog.show({ title: 'tag', message: '打开华为账号用户认证协议' })
                                        } else if (item.tag === '隐私协议') {
                                            AlertDialog.show({ title: 'tag', message: '打开隐私协议' })
                                        } else {
                                            AlertDialog.show({ title: 'tag', message: '打开用户服务协议' })
                                        }
                                        // AlertDialog.show({ title: 'tag', message: item.tag })
                                        // 应用需要根据item.tag实现协议页面的跳转逻辑
                                    })
                            }
                        }, (item: loginComponentManager.PrivacyText) => item.text.toString())
                    }
                    .width('100%')
                }
                .margin({ left: 12 })
                .layoutWeight(1)
                .constraintSize({ minHeight: 24 })
            }
            .alignItems(VerticalAlign.Top)
            .margin({ top: '16.00vp', bottom: '16.00vp' })
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .height('100%')
        .width('100%')
    }

    private openURL(url: string) {
        let context = this.getUIContext().getHostContext() as common.UIAbilityContext;
        let want: Want = {
            uri: "https://privacy.consumer.huawei.com/legal/id/authentication-terms.htm?code=CN&language=zh-CN"
        };
        try {
            context.startAbility(want).then(() => {
                AlertDialog.show({ title: 'Want', message: 'start ability success.' })
            }).catch((err: BusinessError) => {
                AlertDialog.show({ title: 'error', message: JSON.stringify(err) })
            })
        } catch (paramError) {
            AlertDialog.show({ title: 'paramError', message: JSON.stringify(paramError) })
        }
    }
}