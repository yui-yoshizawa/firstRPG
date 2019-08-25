//
//  ViewController.swift
//  firstRPG
//
//  Created by 吉澤優衣 on 2019/08/15.
//  Copyright © 2019 吉澤優衣. All rights reserved.
//

import UIKit
// import SpriteKit    // SpriteKit を使うためインポート

class cave1ViewController: UIViewController {


    @IBOutlet weak var gameView: UIView!
    @IBOutlet weak var playerImage: UIImageView!    // プレイヤー

    /// 【プレイヤーのパラメータ】
    var player: [String: Any] = [
        "name": "ほげぇ",
        "Lv": 1,    // レベル
        "maxHP": 24,    // 最大HP
        "maxMP": 10,    // 最大MP
        "nowHP": 24,
        "nowMP": 10,
        "atk": 12,    // 攻撃力
        "def": 15,    // 守備力
        "agi": 8,    // すばやさ
        "itemAtk": 0,    // 装備の攻撃力
        "itemDef": 0,    // 装備の守備力
        "exp": 0,    // 経験値
        "gold": 0    // 所持金
    ]

    var currentNum = 241    // プレイヤーの位置が配列の何番めか

    var count = 0    // 歩数のカウント

    @IBOutlet weak var restartLocation: UIImageView!


    // プレイヤースタート地点座標
    var playerLeftLocation: CGFloat = 266.5
    var playerRightLocation: CGFloat = 293.5
    var playerOverLocation: CGFloat = 0.0
    var playerUnderLocation: CGFloat = 26.5

    var monster:[Int] = []

    // 配列をくんでやるぜ！！！ (12 * 21 = 252 0スタートだから251まで)
    let line = [
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2, 2, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0,
        0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0,
        0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0,
        0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0
    ]

    /// モンスター名前
    var monsterName1 = ""
    var monsterName2 = ""
    var monsterName3 = ""
    var monsterName4 = ""


    /// モンスターステータス
    var monster1: [String: Int] = [:]
    var monster2: [String: Int] = [:]
    var monster3: [String: Int] = [:]
    var monster4: [String: Int] = [:]


    // 【モンスター情報】
    var monsterStatus: [[String: Int]] = [
        ["hp": 7, "atk": 5, "def": 16, "agi": 1, "exp": 2, "gold": 1],    // 0. スライム
        ["hp": 10, "atk": 6, "def": 18, "agi": 1, "exp": 3, "gold": 1],    // 1. バット
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 2. マタンゴ
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 3. ピヨネズミ
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 4. レイン
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 5. プランタ
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 6. ボーン
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 7. ラコステ
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 8. ナルシカラス
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 9. ゴーレム
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 10. トロール
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 11. ハーミット
        ["hp": 1, "atk": 1, "def": 1, "agi": 1, "exp": 1, "gold": 1],    // 12. ティグレ
        ["hp": 0, "atk": 0, "def": 0, "agi": 0, "exp": 0, "gold": 0]    // 13. なし
    ]

    //let a = monsterStatus[0]["hp"]
    //print(a!)




    // モンスターの名前
    let monsterName: [String] = [
        "スライム",
        "バット",
        "マタンゴ",
        "ピヨネズミ",
        "レイン",
        "プランタ",
        "ボーン",
        "ラコステ",
        "ナルシカラス",
        "ゴーレム",
        "トロール",
        "ハーミット",
        "ティグレ",
        ""
    ]




    override func viewWillAppear(_ animated: Bool) {
        let playerFrame = CGRect(x: playerLeftLocation, y: 26.5 * 11 - playerOverLocation, width: 27.0, height: 26.5)
        print(playerFrame)

        playerImage.frame = playerFrame
    }

    // ステータスバー邪魔だから消す
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }



    // 上ボタンを押している時 touchDown
    @IBAction func upButton(_ sender: UIButton) {
        if currentNum - 21 >= 0 {  // 移動先の配列番号が存在するか確認
            self.currentNum -= 21    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)
            print(currentNum)

            if self.line[currentNum] == 1 {    // 1なら移動可能
                // 【普通に移動できるとき】
                // 1. プレイヤーを移動させる
                UIView.animate(withDuration: 1, animations: {
                    self.playerImage.center.y -= self.gameView.frame.size.height / 12
                })
                // 2. 歩数をカウントする
                count += 1

                // 3. エンカウント処理
                encount()


            } else if self.line[currentNum] == 0 {
                // 【障害物にあたったとき】
                self.currentNum += 21    // 移動しないんだから配列番号も戻す
            }
        }
    }

    // 左ボタン
    @IBAction func leftButton(_ sender: UIButton) {
        if currentNum - 1 >= 0 {  // 移動先の配列番号が存在するか確認
            self.currentNum -= 1    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)

            if self.line[currentNum] == 1 {    // 1なら移動可能
                UIView.animate(withDuration: 1, animations: {
                    self.playerImage.center.x -= self.gameView.frame.size.width / 21
                })

                // 2. 歩数をカウントする
                count += 1

                // 3. エンカウント処理
                encount()

            } else if self.line[currentNum] == 0 {
                // 【障害物にあたったとき】
                self.currentNum += 1    // 移動しないんだから配列番号も戻す
            }
        }
    }

    // 右ボタン
    @IBAction func rightButton(_ sender: UIButton) {
        if currentNum + 1 <= 251 {  // 移動先の配列番号が存在するか確認
            self.currentNum += 1    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)

            if self.line[currentNum] == 1 {    // 1なら移動可能
                UIView.animate(withDuration: 1, animations: {
                    self.playerImage.center.x += self.gameView.frame.size.width / 21
                })

                // 2. 歩数をカウントする
                count += 1

                // 3. エンカウント処理
                encount()

            } else if self.line[currentNum] == 0 {
                // 【障害物にあたったとき】
                self.currentNum -= 1    // 移動しないんだから配列番号も戻す
            }
        }
    }

    // 下ボタン
    @IBAction func downButton(_ sender: UIButton) {
        if currentNum + 21 <= 251 {  // 移動先の配列番号が存在するか確認
            self.currentNum += 21    // 配列番号を移動先の番号に変える。(self つけないとボタンが反応してくれなくなる)

            if self.line[currentNum] == 1 {    // 1なら移動可能
                // 【普通に移動できるとき】
                UIView.animate(withDuration: 1, animations: {
                    self.playerImage.center.y += self.gameView.frame.size.height / 12
                })

                // 2. 歩数をカウントする
                count += 1

                // 3. エンカウント処理
                encount()


            } else if self.line[currentNum] == 0 {
                // 【障害物にあたったとき】
                self.currentNum -= 21    // 移動しないんだから配列番号も戻す
            }
        }
    }


    // 【敵とエンカウントする処理】を書きたい！
    func encount() {
        print("えんかうんと")
        // 1. エンカウントが発生した時にどのモンスターを何匹出現させるか決定
        // 何匹か(2匹か4匹)
        let howMany = Int.random(in: 0...1)    // 0なら2匹、1なら4匹出現
        switch howMany {
        case 0:    // 2匹の場合
            let noMonster = 13
            let monsterA = Int.random(in: 0...1)    // このマップでは0,1のモンスターが出現。
            let monsterB = Int.random(in: 0...1)
            monster = [noMonster, monsterA, monsterB, noMonster]    // バトルシーン遷移時にこの値を渡してモンスターを出現させる。


            monster1 = monsterStatus[monster[0]]    // モンスターのステータスを入れる
            monsterName1 = monsterName[monster[0]]    // 1匹目の名前を取得

            monster2 = monsterStatus[monster[1]]    // モンスターのステータスを入れる
            monsterName2 = monsterName[monster[1]]    // 1匹目の名前を取得

            monster3 = monsterStatus[monster[2]]    // モンスターのステータスを入れる
            monsterName3 = monsterName[monster[2]]    // 1匹目の名前を取得

            monster4 = monsterStatus[monster[3]]    // モンスターのステータスを入れる
            monsterName4 = monsterName[monster[3]]    // 1匹目の名前を取得



        case 1:    // 4匹の場合
            let monsterC = Int.random(in: 0...1)
            let monsterD = Int.random(in: 0...1)
            let monsterE = Int.random(in: 0...1)
            let monsterF = Int.random(in: 0...1)
            monster = [monsterC, monsterD, monsterE, monsterF]


            monster1 = monsterStatus[monster[0]]    // モンスターのステータスを入れる
            monsterName1 = monsterName[monster[0]]    // 1匹目の名前を取得

            monster2 = monsterStatus[monster[1]]    // モンスターのステータスを入れる
            monsterName2 = monsterName[monster[1]]    // 1匹目の名前を取得

            monster3 = monsterStatus[monster[2]]    // モンスターのステータスを入れる
            monsterName3 = monsterName[monster[2]]    // 1匹目の名前を取得

            monster4 = monsterStatus[monster[3]]    // モンスターのステータスを入れる
            monsterName4 = monsterName[monster[3]]    // 1匹目の名前を取得

        default:
            return
        }





        // 2. どんな条件でエンカウントが発生するのか
        // まず0-9の乱数を発生させる
        let int = Int.random(in: 0..<10)
        switch count {
        case 2:    // 歩数が2歩の時
            if int < 1 {    // 乱数が0だったら遷移して戦闘
                performSegue(withIdentifier: "toBattle", sender: nil)
                print("せんい")
            }
        case 5:    // 歩数が5歩の時
            if int < 6 {     // 乱数が0~5だったら遷移して戦闘
                performSegue(withIdentifier: "toBattle", sender: nil)
                print("せんい")
            }
        case 8:    // 歩数が8歩の時
            if int < 9 {    // 乱数が0~8だったら遷移して戦闘
                performSegue(withIdentifier: "toBattle", sender: nil)
                print("せんい")
            }
        case 10:    // 歩数が10歩の時
            performSegue(withIdentifier: "toBattle", sender: nil)    // 強制で戦闘
            print("せんい")

        default:
            return
        }
    }


    // 3. 画面遷移で渡す値
    // 1. モンスター情報
    // 2. プレイヤー情報
    // それ以外なんかあるっけ

    // segue遷移前動作
    // セグエ実行前処理 / セグエの identifier 確認 / 遷移先ViewController の取得
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toBattle", let vc = segue.destination as? battleMessageViewController else {
            return
        }
        // プレイヤーの情報
        vc.player = player

        // エンカウントしたモンスター情報を渡す
        vc.monsterName1 = monsterName1
        vc.monster1 = monster1

        vc.monsterName2 = monsterName2
        vc.monster2 = monster2

        vc.monsterName3 = monsterName3
        vc.monster3 = monster3

        vc.monsterName4 = monsterName4
        vc.monster4 = monster4

        // モンスター出現処理を呼ぶ
        vc.toMonsterApper = true


        // プレイヤー座標格納
        playerLeftLocation = playerImage.frame.origin.x
        playerRightLocation = playerImage.frame.origin.x + playerImage.frame.size.width
        playerOverLocation = playerImage.frame.origin.y
        playerUnderLocation = playerImage.frame.origin.y + playerImage.frame.size.height

        vc.playerLeftLocation = playerLeftLocation
        vc.playerRightLocation = playerRightLocation
        vc.playerOverLocation = playerOverLocation
        vc.playerUnderLocation = playerUnderLocation

        vc.currentNum = currentNum

        print(playerLeftLocation)
        print(playerOverLocation)



    }


}
