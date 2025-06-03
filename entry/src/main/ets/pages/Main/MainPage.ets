import { ContentFourPage } from './ContentFourPage';
import { ContentThreePage } from './ContentThreePage';
import { ContentTwoPage } from './ContentTwoPage';
import { ContentOnePageV2 } from './SubPages/ContentOnePageV2';

@Preview
@Entry
@Component
struct MainPage {
    @State currentIndex: number = 0;

    @Builder
    tabBuilder(title: string, targetIndex: number, selectedIcon: Resource, unselectIcon: Resource) {
        Column() {
            Image(this.currentIndex === targetIndex ? selectedIcon : unselectIcon)
                .width(24)
                .height(24)
            Text(title)
                .fontFamily('HarmonyHeiTi-Medium')
                .fontSize(10)
                .fontColor(this.currentIndex === targetIndex ? '#0A59F7' : 'rgba(0,0,0,0.60)')
                .textAlign(TextAlign.Center)
                .lineHeight(14)
                .fontWeight(500)
        }
        .width('100%')
        .height(50)
        .justifyContent(FlexAlign.Center)
    }

    build() {
        Tabs({ barPosition: BarPosition.End }) {
            TabContent() {
                // ContentOnePage()
                ContentOnePageV2()
            }
            .tabBar(this.tabBuilder("吃药打卡", 0, $r('app.media.icon'), $r('app.media.icon')))

            TabContent() {
                // ProductTab()
                ContentTwoPage()
            }
            .tabBar(this.tabBuilder('我的用药', 1, $r('app.media.icon'), $r('app.media.icon')))

            TabContent() {
                ContentThreePage()
            }
            .tabBar(this.tabBuilder('用药记录', 2, $r('app.media.message'), $r('app.media.message')))

            TabContent() {
                ContentFourPage()
            }
            .tabBar(this.tabBuilder('我的', 3, $r('app.media.circle'), $r('app.media.circle')))
        }
        .scrollable(false)
        .onChange((val) => {
            this.currentIndex = val
        })
    }
}