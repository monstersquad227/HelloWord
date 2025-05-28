@Component
@Entry
export struct ProductTab {
    @State products: string[] = [];
    @State loading: boolean = true; // 添加加载状态变量

    onDidBuild() {
        this.loadProducts();
    }

    build() {
        Column() {
            // 使用 loading 状态控制显示
            if (this.loading) {
                Column() {
                    LoadingProgress()
                        .width(50)
                        .height(50)
                    Text('加载中...')
                        .margin({ top: 10 })
                        .fontColor('#999')
                }
                .justifyContent(FlexAlign.Center)
                .height('100%')
            } else {
                List() {
                    ForEach(this.products, (item: string) => {
                        ListItem() {
                            Text(item)
                                .fontSize(16)
                                .padding(10)
                        }
                    }, (item: string) => item)
                }
                .width('100%')
                .layoutWeight(1)
            }
        }
        .width('100%')
        .height('100%')
    }

    private loadProducts() {
        // 1. 显示加载状态
        this.loading = true;

        // 2. 使用异步操作模拟数据加载
        setTimeout(() => {
            // 3. 更新数据
            this.products = ['商品1', '商品2', '商品3'];

            // 4. 隐藏加载状态
            this.loading = false;
        }, 1000); // 模拟1秒延迟
    }
}