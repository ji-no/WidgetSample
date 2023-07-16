//
//  ImageListService.swift
//  WidgetSample
//  
//  Created by ji-no on 2023/07/17
//  
//

import Combine

typealias ImageInfo = (title: String, url: String)

class ImageListService {
    let images: [ImageInfo] = [
        (title: "ラベンダー畑", url: "https://1.bp.blogspot.com/-tN6cxEx1kvM/X7zMFOAnmQI/AAAAAAABcX4/4UjrbGfFHIE59wHINvkF03bzXmL3FzMSACNcBGAsYHQ/s400/bg_lavender_flower.jpg"),
        (title: "空に打ち上がる花火", url: "https://2.bp.blogspot.com/--XyGmSuFJtk/XOPXPWcaKTI/AAAAAAABS6s/9zxLQUKTqzUs9NW4mJWhUvdaG8P_Ab66ACLcBGAs/s400/hanabi_sky.png"),
        (title: "緑のチェック柄", url: "https://4.bp.blogspot.com/-P6hcAiGH5tM/XJB4o9PCeXI/AAAAAAABR4o/1jsOQ6q51io1x7g0VrloLp_Ck0p_4OLlACLcBGAs/s400/christmas_check_pattern_green.png"),
        (title: "赤のチェック柄", url: "https://3.bp.blogspot.com/-AxyELGPAOVk/XJB4pHZiczI/AAAAAAABR4s/e8-XbZ_4lB4F4M1z-zDNRIKVMwJbm4FswCLcBGAs/s400/christmas_check_pattern_red.png"),
        (title: "おもちゃ屋", url: "https://3.bp.blogspot.com/-Dh-Mg5g3gVA/WtRyxal4kZI/AAAAAAABLhc/q9dIX7_Fj3gK4MokFS0juvVxSx1xSJxMgCLcBGAs/s400/building_omocha.png"),
        (title: "ダイアモンドダスト", url: "https://4.bp.blogspot.com/-2VRNdggYAgQ/W1a4g3dvDTI/AAAAAAABNgE/nNiEgghSMTwYS0QgcNdQg6uCu_Ph38BjACLcBGAs/s180-c/bg_snow_diamond_dust.jpg"),
        (title: "桜並木", url: "https://2.bp.blogspot.com/-ngdlNja37lk/XJhwPsT0QtI/AAAAAAABSEc/WnLJE71Okgsn_IHlNfzohvE0CXfLOTEkACLcBGAs/s180-c/bg_namikimichi1_sakura.jpg"),
        (title: "川の中", url: "https://1.bp.blogspot.com/-0XUYPcO40n8/X5OcHdsaQTI/AAAAAAABb5M/9FW4NZlp5oklDgUSqAa9i3cekGp8PjGQACNcBGAsYHQ/s180-c/bg_natural_river.jpg"),
        (title: "紅葉した山と田んぼ", url: "https://4.bp.blogspot.com/-Eh202n-SoSs/We6SagKmT-I/AAAAAAABHxk/AzQtRIej8IIdZ4VbbL7buQolpzQO-UACgCLcBGAs/s180-c/bg_tanbo_aki.jpg"),
        (title: "ホログラムシール", url: "https://4.bp.blogspot.com/-aOCh3m2lvJs/WEVof8kUhjI/AAAAAAABANo/nd7um4KXL3QMh7AahC2gAsGFq7sI2qvrgCLcB/s180-c/hologram_kira_sticker_color.png"),
    ]

    func fetch() -> Future<[ImageInfo], Never> {
        return Future() { promise in
            promise(Result.success(self.images))
        }
    }
    
}
