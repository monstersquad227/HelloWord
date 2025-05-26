interface todayInterface {
    year: number;
    month: number;
    day: number;
}

@Preview
@Component
export struct CalendarPage {
    @State year: number = new Date().getFullYear();
    @State month: number = new Date().getMonth() + 1;
    @State days: Array<string> = this.generateDays();
    private weekTitles: Array<string> = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
    private readonly today: todayInterface = {
        year: new Date().getFullYear(),
        month: new Date().getMonth() + 1,
        day: new Date().getDate()
    };

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
                        this.days = this.generateDays()
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
                        this.days = this.generateDays()
                    })
            }

            // 日历主体
            Grid() {
                ForEach(this.weekTitles, (weekTitles: string) => {
                    GridItem() {
                        Text(weekTitles)
                    }
                    .height(40)
                    .width(40)
                }, (weekTitles: string): string => weekTitles)

                ForEach(this.days, (days: string) => {
                    GridItem() {
                        Text(days !== '' ? days : ' ')
                            .fontSize(14)
                            .fontColor(
                                this.year === this.today.year &&
                                    this.month === this.today.month &&
                                    parseInt(days) === this.today.day
                                    ? '#ffffff'
                                    : '#000000'
                            )
                            .width(30)
                            .height(30)
                            .textAlign(TextAlign.Center)// .backgroundColor(days !== '' ? '#e6f7ff' : 'transparent')
                            .backgroundColor(
                                days !== '' &&
                                    this.year === this.today.year &&
                                    this.month === this.today.month &&
                                    parseInt(days) === this.today.day
                                    ? Color.Red
                                    : 'transparent')
                            .borderRadius(15)
                    }
                    .height(30)
                    .width(30)
                }, (day: string): string => day + Math.random())

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
        const days: string[] = [];
        // 获取该月第一天是星期几（0=周日，6=周六）
        const firstDayDate = new Date(this.year, this.month - 1, 1)
        const firstDayOfWeek = firstDayDate.getDay()
        // 这个月有多少天
        const daysInMonth = new Date(this.year, this.month, 0).getDate()
        // 添加前导空白
        for (let i = 0; i < firstDayOfWeek; i++) {
            days.push('')
        }
        // 添加实际天数
        for (let i = 1; i <= daysInMonth; i++) {
            days.push(i.toString())
        }
        return days
    }

    private formatDate(year: number, month: number): string {
        return `${year}-${month.toString().padStart(2, '0')}`;
    }
}
