@Preview
@Component
export struct CalendarPage {
    @State year: number = new Date().getFullYear();
    @State month: number = new Date().getMonth() + 1;
    @State days: Array<string> = this.generateDays();

    onInit() {
        this.generateDays();
    }

    build() {
        Column() {
            // 日期头
            Row() {
                Image($r('app.media.right_grey'))
                    .rotate({ angle: 180 })
                    .width(16)
                    .height(16)
                    .onClick(() => {
                        this.getPreviousMonth()
                    })
                Text(`${this.formatDate(this.year, this.month)}`)
                    .fontSize(20)
                    .fontWeight('bold')
                    .padding(10)
                Image($r('app.media.right_grey'))
                    .width(16)
                    .height(16)
                    .onClick(() => {
                        this.getNextMonth()
                    })
            }

            // 日历主体
            Grid() {
                ForEach(this.days, (days: string) => {
                    GridItem() {
                        Text(days)
                    }
                    .height(40)
                    .width(40)
                    .backgroundColor('#e6f7ff')
                    .borderRadius(6)
                }, (days: string): string => days)

            }
            .rowsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr' as string)
            .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr' as string)
        }
        .height('100%')
        .width('100%')
    }

    private getPreviousMonth() {
        if (this.month === 1) {
            this.year -= 1;
            this.month = 12;
        } else {
            this.month -= 1;
        }
        this.generateDays()
    }

    private getNextMonth() {
        if (this.month === 12) {
            this.year += 1;
            this.month = 1;
        } else {
            this.month += 1;
        }
        this.generateDays()
    }

    private generateDays(): Array<string> {
        const daysInMonth = new Date(this.year, this.month, 0).getDate();
        const newDays: string[] = [];
        for (let i = 1; i <= daysInMonth; i++) {
            newDays.push(i.toString());
        }
        return newDays;
    }

    private formatDate(year: number, month: number): string {
        return `${year}-${month.toString().padStart(2, '0')}`;
    }
}
