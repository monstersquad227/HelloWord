import { ContentThreeIterm } from '../../view/ContentThreeIterm';

interface ContentThreeItermInterface {
    date: string;
    content: string;
}

@Preview
@Component
export struct ContentThreePage {
    @State notesIterm: Array<ContentThreeItermInterface> = [
        { date: '2025-05-25', content: '真菌王抑菌膏\n真菌王抑菌膏\n真菌王抑菌膏' },
        { date: '2025-05-24', content: '真菌王抑菌膏' }, { date: '2025-05-23', content: '真菌王抑菌膏' },
        { date: '2025-05-22', content: '真菌王抑菌膏' }, { date: '2025-05-21', content: '真菌王抑菌膏' },
        { date: '2025-05-20', content: '没有打卡记录' }, { date: '2025-05-19', content: '没有打卡记录' },
        { date: '2025-05-18', content: '没有打卡记录' }, { date: '2025-05-17', content: '没有打卡记录' },
        { date: '2025-05-16', content: '没有打卡记录' }, { date: '2025-05-15', content: '没有打卡记录' },
    ]

    build() {
        Column() {
            List() {
                ForEach(this.notesIterm, (item: ContentThreeItermInterface) => {
                    ListItem() {
                        ContentThreeIterm({ date: item.date, content: item.content })
                    }
                })
            }
            .padding(10)
            .alignListItem(ListItemAlign.Center)
            .scrollBar(BarState.Auto)

            // List() {
            //     ListItem() {
            //         Column() {
            //             Row() {
            //                 Text('2025-05-21')
            //                     .fontSize(18)
            //                     .fontWeight(FontWeight.Medium)
            //                     .backgroundColor($r('app.media.background'))
            //                 Image($r('app.media.right_grey'))
            //                     .width('16')
            //                     .height('16')
            //             }
            //             .width('100%')
            //             .justifyContent(FlexAlign.SpaceBetween)
            //
            //             Row() {
            //                 Text('我是内容')
            //                     .fontSize(14)
            //                     .fontColor('#888888')
            //                     .margin({ top: 4 })
            //             }
            //             .width('100%')
            //             .justifyContent(FlexAlign.Start)
            //
            //         }
            //         .width('100%')
            //     }
            // }
            // .padding(20)
            // .alignListItem(ListItemAlign.Center)
        }
        .width('100%')
        .height('100%')
    }
}