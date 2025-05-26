/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

@Component
export default struct ToDoItem {
    public content?: string;

    build() {
        // Row() {
        //     Text(this.content)
        //         .fontSize($r('app.float.item_font_size'))
        //         .fontWeight(CommonConstants.FONT_WEIGHT)
        // }
        // .borderRadius(CommonConstants.BORDER_RADIUS)
        // .backgroundColor($r('app.color.start_window_background'))
        // .width(CommonConstants.LIST_DEFAULT_WIDTH)
        // .height($r('app.float.list_item_height'))
    }
}