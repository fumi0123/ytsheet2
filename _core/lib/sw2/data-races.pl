#################### 種族 ####################
use strict;
use utf8;

package data;

## ●種族リスト
 # ['ソート順' , '名前' , '種族特徴' , '6Lv追加特徴' ,'11Lv追加特徴' ,'16Lv追加特徴']
our @races = (
  ['001', '人間', '［剣の加護／運命変転］'],
  ['002', 'エルフ', '［暗視］［剣の加護／優しき水］'],
  ['003', 'ドワーフ', '［暗視］［剣の加護／炎身］'],
  ['004', 'タビット', '［第六感］'],
  ['005', 'ルーンフォーク', '［暗視］［HP変換］'],
  ['006', 'ナイトメア（人間）', '［異貌］［弱点／土］'],
  ['006', 'ナイトメア（エルフ）', '［異貌］［弱点／水・氷］'],
  ['006', 'ナイトメア（ドワーフ）', '［異貌］［弱点／炎］'],
  ['006', 'ナイトメア（リルドラケン）', '［異貌］［弱点／風］'],
  ['007', 'リカント', '［暗視(獣変貌)］［獣変貌］'],
  ['008', 'リルドラケン', '［鱗の皮膚］［尻尾が武器］［剣の加護／風の翼］'],
  ['009', 'グラスランナー', '［マナ不干渉］［虫や植物との意思疎通］'],
  ['010', 'メリア', '［繁茂する生命］'],
  ['011', 'ティエンス', '［通じ合う意識］'],
  ['012', 'レプラカーン', '［暗視］［見えざる手］［姿なき職人］'],
  ['013', 'シャドウ', '［暗視］［月光の守り］'],
  ['014', 'フィー', '［妖精の加護］［浮遊］'],
  ['015', 'フロウライト', '［魂の輝き］［鉱石の生命］［晶石の身体］'],
  ['016', 'ハイマン', '［魔法の申し子］［デジャヴ］'],
  ['017', 'ミアキス', '［暗視］［猫変化］［獣性の発露］'],
  ['018', 'ヴァルキリー', '［戦乙女の光羽］［戦乙女の祝福］'],
  ['019', 'ソレイユ', '［輝く肉体］［太陽の再生］［太陽の子］'],
  ['020', 'センティアン（ルミエル）',   '［刻まれし聖印］［神の恩寵］［神の御名と共に］'],
  ['020', 'センティアン（イグニス）',   '［刻まれし聖印］［暗視］［神の兵士］［神への礼賛］'],
  ['020', 'センティアン（カルディア）', '［刻まれし聖印］［神の庇護］［神への祈り］'],
  ['101', 'ノーブルエルフ', '［暗視］［剣の加護／水の申し子］［カリスマ］［痛みに弱い］'],
  ['102', 'マナフレア', '［溢れるマナ］［マナの手］'],
  ['201', '魔動天使', '［暗視］［造られし強さ］［鋼鉄の翼］［契約の絆］'],
  ['a01', 'ダークドワーフ', '［暗視］［黒炎の遣い手］'],
  ['b01', 'ドレイク（ナイト）', '［暗視］［魔剣の所持］［飛行（飛翔）］［竜化］'],
  ['b02', 'ドレイク（ブロークン）', '［暗視］［限定竜化］'],
  ['b03', 'バジリスク', '［邪視と瞳石］［猛毒の血液］［魔物化］'],
  ['b04', 'リザードマン', '［尻尾が武器］［水中活動］［無呼吸活動］', ['［仲間との連携］','［敵への憤怒］'], ['［仲間との連携］','［敵への憤怒］'], ['［仲間との連携］','［敵への憤怒］'] ],
  ['b05', 'ケンタウロス', '［半馬半人］［馬人の武術］'],
  ['b06', 'ダークトロール', '［暗視］［弱体化］［トロールの体躯］' , '', '［限定再生］'],
  ['b07', 'ラミア', '［暗視］［ラミアの身体］［ラミアの吸血］［変化］'],
  ['b08', 'ライカンスロープ', '［暗視］［獣人の力］［獣化］'],
  ['b09', 'コボルド', '［種の限界］［軽視］［小さな匠］'],
  ['b10', 'ウィークリング（ガルーダ）', '［蛮族の身体］［未熟な翼］［切り裂く風］'],
  ['b10', 'ウィークリング（バジリスク）', '［蛮族の身体］［石化の視線］［毒の血液］'],
  ['b10', 'ウィークリング（マーマン）', '［蛮族の身体］［水中適性］［水・氷耐性］', '［バブルフォーム］'],
  ['b10', 'ウィークリング（ミノタウロス）', '［蛮族の身体］［暗視］［剛力］'],
  ['b11', 'ラルヴァ', '［暗視］［吸血の祝福］［忌むべき血］［弱体化］'],
  ['b12', 'バルカン', '［暗視］［炎無効］［バルカンの宝石］', '［強制召喚］'],
);

our @race_names;
our %race_ability;
foreach (@races){
  push (@race_names, @$_[1]);
  $race_ability{@$_[1]} = @$_[2];
}

## ●種族ごとの言語
 # '種族名' => [
 #   [ '言語名' , 会話, 読文 ], 習得＝1　会話／読文なし＝0　未習得＝2
 # ],
our %race_language = (
  '人間' => [
    [ '交易共通語', 1, 1 ],
  ],
  'エルフ' => [
    [ '交易共通語', 1, 1 ],
    [ 'エルフ語', 1, 1 ],
  ],
  'ドワーフ' => [
    [ '交易共通語', 1, 1 ],
    [ 'ドワーフ語', 1, 1 ],
  ],
  'タビット' => [
    [ '交易共通語', 1, 1 ],
    [ '神紀文明語', 0, 1 ],
  ],
  'ルーンフォーク' => [
    [ '交易共通語', 1, 1 ],
    [ '魔動機文明語', 1, 1 ],
  ],
  'ナイトメア（人間）' => [
    [ '交易共通語', 1, 1 ],
  ],
  'ナイトメア（エルフ）' => [
    [ '交易共通語', 1, 1 ],
    [ 'エルフ語', 1, 1 ],
  ],
  'ナイトメア（ドワーフ）' => [
    [ '交易共通語', 1, 1 ],
    [ 'ドワーフ語', 1, 1 ],
  ],
  'ナイトメア（リルドラケン）' => [
    [ '交易共通語', 1, 1 ],
    [ 'ドラゴン語', 1, 0 ],
  ],
  'リカント' => [
    [ '交易共通語', 1, 1 ],
    [ 'リカント語', 1, 1 ],
  ],
  'リルドラケン' => [
    [ '交易共通語', 1, 1 ],
    [ 'ドラゴン語', 1, 0 ],
  ],
  'グラスランナー' => [
    [ '交易共通語', 1, 1 ],
    [ 'グラスランナー語', 1, 1 ],
  ],
  'メリア' => [
    [ '交易共通語', 1, 1 ],
    [ '妖精語', 1, 0 ],
  ],
  'ティエンス' => [
    [ '交易共通語', 1, 1 ],
    [ '魔神語', 1, 0 ],
  ],
  'シャドウ' => [
    [ '交易共通語', 1, 1 ],
    [ 'シャドウ語', 1, 1 ],
  ],
  'フィー' => [
    [ '交易共通語', 1, 1 ],
    [ '妖精語', 1, 0 ],
  ],
  'フロウライト' => [
    [ '交易共通語', 1, 1 ],
  ],
  'ハイマン' => [
    [ '交易共通語', 1, 1 ],
    [ '魔法文明語', 1, 1 ],
  ],
  'ミアキス' => [
    [ '交易共通語', 1, 1 ],
    [ 'ミアキス語', 1, 0 ],
  ],
  'ヴァルキリー' => [
    [ '交易共通語', 1, 1 ],
  ],
  'ソレイユ' => [
    [ '交易共通語', 1, 1 ],
    [ 'ソレイユ語', 1, 0 ],
  ],
  'レプラカーン' => [
    [ '交易共通語', 1, 1 ],
    [ '魔動機文明語', 1, 1 ],
  ],
  'センティアン（ルミエル）' => [
    [ '神紀文明語', 0, 1 ],
  ],
  'センティアン（イグニス）' => [
    [ '神紀文明語', 0, 1 ],
  ],
  'センティアン（カルディア）' => [
    [ '神紀文明語', 0, 1 ],
  ],
  'ノーブルエルフ' => [
    [ 'エルフ語', 1, 1 ],
    [ '魔法文明語', 1, 1 ],
  ],
  'マナフレア' => [
    [ '魔法文明語', 1, 1 ],
  ],
  '魔動天使' => [
    [ '交易共通語', 1, 1 ],
    [ '魔動機文明語', 1, 1 ],
  ],
  'ダークドワーフ' => [
    [ '交易共通語', 1, 1 ],
    [ 'ドワーフ語', 1, 1 ],
    [ '汎用蛮族語', 1, 1 ],
  ],
  'ドレイク（ナイト）' => [
    [ '交易共通語', 1, 1 ],
    [ '汎用蛮族語', 1, 1 ],
    [ 'ドレイク語', 1, 1 ],
  ],
  'ドレイク（ブロークン）' => [
    [ '交易共通語', 1, 1 ],
    [ '汎用蛮族語', 1, 1 ],
    [ 'ドレイク語', 1, 1 ],
  ],
  'バジリスク' => [
    [ '交易共通語', 1, 1 ],
    [ '汎用蛮族語', 1, 1 ],
    [ 'バジリスク語', 1, 1 ],
    [ 'ドレイク語', 1, 1 ],
    [ '妖魔語', 1, 0. ],
  ],
  'リザードマン' => [
    [ '汎用蛮族語', 1, 1 ],
    [ 'リザードマン語', 1, 1 ],
    [ 'ドラゴン語', 1, 0. ],
  ],
  'ケンタウロス' => [
    [ '汎用蛮族語', 1, 1 ],
    [ 'ケンタウロス語', 1, 1 ],
  ],
  'ダークトロール' => [
    [ '汎用蛮族語', 1, 1 ],
    [ '巨人語', 1, 1 ],
  ],
  'ラミア' => [
    [ '交易共通語', 1, 1 ],
    [ '汎用蛮族語', 1, 1 ],
    [ 'ドレイク語', 1, 1 ],
  ],
  'ライカンスロープ' => [
    [ '交易共通語', 1, 1 ],
    [ '汎用蛮族語', 1, 1 ],
    [ 'ライカンスロープ語', 1, 1 ],
  ],
  'ウィークリング（ガルーダ）' => [
    [ '交易共通語', 1, 1 ],
    [ '汎用蛮族語', 1, 1 ],
  ],
  'ウィークリング（バジリスク）' => [
    [ '交易共通語', 1, 1 ],
    [ '汎用蛮族語', 1, 1 ],
  ],
  'ウィークリング（マーマン）' => [
    [ '交易共通語', 1, 1 ],
    [ '汎用蛮族語', 1, 1 ],
  ],
  'ウィークリング（ミノタウロス）' => [
    [ '交易共通語', 1, 1 ],
    [ '汎用蛮族語', 1, 1 ],
  ],
  'ラルヴァ' => [
    [ '交易共通語', 1, 1 ],
  ],
  'バルカン' => [
    [ '汎用蛮族語', 1, 1 ],
    [ 'バルカン語', 1, 1 ],
  ],
);

our %race_dices = (
  '人間' => {
    'A' => 2, 'B' => 2, 'C' => 2, 'D' => 2, 'E' => 2, 'F' => 2,
  },
  'エルフ' => {
    'A' => 2, 'B' => 2, 'C' => 1, 'D' => 2, 'E' => 2, 'F' => 2,
  },
  'ドワーフ' => {
    'A' => 2, 'B' => 1, 'C' => 2, 'D' => 2, 'E' => 1, 'F' => 2,
    'A+'=> 6,                                         'F+'=> 6,
  },
  'タビット' => {
    'A' => 1, 'B' => 1, 'C' => 1, 'D' => 2, 'E' => 2, 'F' => 2,
                                            'E+'=> 6,
  },
  'ルーンフォーク' => {
    'A' => 2, 'B' => 1, 'C' => 2, 'D' => 2, 'E' => 2, 'F' => 1,
  },
  'ナイトメア' => {
    'A' => 2, 'B' => 2, 'C' => 1, 'D' => 1, 'E' => 2, 'F' => 2,
  },
  'リカント' => {
    'A' => 1, 'B' => 1, 'C' => 2, 'D' => 2, 'E' => 1, 'F' => 1,
              'B+'=> 3,                     'E+'=> 6, 
  },
  'リルドラケン' => {
    'A' => 1, 'B' => 2, 'C' => 2, 'D' => 2, 'E' => 1, 'F' => 2,
                                  'D+'=> 6,
  },
  'グラスランナー' => {
    'A' => 2, 'B' => 2, 'C' => 1, 'D' => 2, 'E' => 1, 'F' => 2,
                                  'D+'=> 6,           'F+'=> 6,
  },
  'メリア' => {
    'A' => 1, 'B' => 1, 'C' => 1, 'D' => 2, 'E' => 1, 'F' => 1,
                                  'D+'=> 6,
  },
  'ティエンス' => {
    'A' => 2, 'B' => 2, 'C' => 1, 'D' => 1, 'E' => 2, 'F' => 2,
                                  'D+'=> 3,           'F+'=> 3,
  },
  'レプラカーン' => {
    'A' => 2, 'B' => 1, 'C' => 2, 'D' => 2, 'E' => 2, 'F' => 2,
  },
  'シャドウ' => {
    'A' => 1, 'B' => 1, 'C' => 2, 'D' => 2, 'E' => 2, 'F' => 2,
  },
  'フィー' => {
    'A' => 2, 'B' => 2, 'C' => 1, 'D' => 1, 'E' => 1, 'F' => 2,
              'B+'=> 6,
  },
  'フロウライト' => {
    'A' => 2, 'B' => 2, 'C' => 2, 'D' => 2, 'E' => 1, 'F' => 2,
                        'C+'=> 6,                     'F+'=> 6,
  },
  'ハイマン' => {
    'A' => 2, 'B' => 1, 'C' => 2, 'D' => 1, 'E' => 1, 'F' => 1,
  },
  'ミアキス' => {
    'A' => 1, 'B' => 2, 'C' => 1, 'D' => 2, 'E' => 2, 'F' => 2,
                                            'E+'=> 6,
  },
  'ヴァルキリー' => {
    'A' => 2, 'B' => 1, 'C' => 2, 'D' => 2, 'E' => 1, 'F' => 1,
                                                      'F+'=> 6,
  },
  'ソレイユ' => {
    'A' => 1, 'B' => 2, 'C' => 1, 'D' => 2, 'E' => 1, 'F' => 2,
                        'C+'=> 6,
  },
  'センティアン（ルミエル）' => {
    'A' => 1, 'B' => 2, 'C' => 1, 'D' => 2, 'E' => 2, 'F' => 2,
  },
  'センティアン（イグニス）' => {
    'A' => 1, 'B' => 2, 'C' => 2, 'D' => 1, 'E' => 2, 'F' => 2,
                                  'D+'=> 6,
  },
  'センティアン（カルディア）' => {
    'A' => 1, 'B' => 2, 'C' => 1, 'D' => 1, 'E' => 1, 'F' => 1,
                                            'E+'=> 6, 'F+'=> 6,
  },
  'ノーブルエルフ' => {
    'A' => 2, 'B' => 2, 'C' => 1, 'D' => 2, 'E' => 2, 'F' => 2,
  },
  'マナフレア' => {
    'A' => 2, 'B' => 1, 'C' => 2, 'D' => 2, 'E' => 2, 'F' => 1,
              'B+'=> 6, 'C+'=> 6,                     'F+'=> 6,
  },
  'ダークドワーフ' => {
    'A' => 2, 'B' => 1, 'C' => 2, 'D' => 1, 'E' => 1, 'F' => 2,
    'A+'=> 6,                                         'F+'=> 6,
  },
  'ドレイク（ブロークン）' => {
    'A' => 1, 'B' => 1, 'C' => 2, 'D' => 2, 'E' => 2, 'F' => 2,
                                            'E+'=> 6,
  },
  'ドレイク（ナイト）' => {
    'A' => 1, 'B' => 1, 'C' => 2, 'D' => 2, 'E' => 2, 'F' => 2,
                                            'E+'=> 6,
  },
  'バジリスク' => {
    'A' => 1, 'B' => 2, 'C' => 2, 'D' => 2, 'E' => 1, 'F' => 1,
    'A+'=> 6,
  },
  'リザードマン' => {
    'A' => 1, 'B' => 2, 'C' => 2, 'D' => 2, 'E' => 2, 'F' => 1,
  },
  'ケンタウロス' => {
    'A' => 2, 'B' => 1, 'C' => 2, 'D' => 2, 'E' => 1, 'F' => 2,
    'A+'=> 6,
  },
  'ダークトロール' => {
    'A' => 2, 'B' => 1, 'C' => 2, 'D' => 2, 'E' => 1, 'F' => 2,
                                  'D+'=> 6,
  },
  'ラミア' => {
    'A' => 1, 'B' => 2, 'C' => 1, 'D' => 2, 'E' => 2, 'F' => 2,
  },
  'ライカンスロープ' => {
    'A' => 2, 'B' => 2, 'C' => 2, 'D' => 2, 'E' => 2, 'F' => 2,
                                  'D+'=> 6,
  },
  'コボルド' => {
    'A' => 2, 'B' => 2, 'C' => 1, 'D' => 1, 'E' => 2, 'F' => 2,
  },
  'ウィークリング' => {
    'A' => 2, 'B' => 2, 'C' => 2, 'D' => 2, 'E' => 2, 'F' => 2,
  },
  'ラルヴァ' => {
    'A' => 1, 'B' => 2, 'C' => 2, 'D' => 1, 'E' => 2, 'F' => 1,
                        'C+'=> 6,
  },
  'バルカン' => {
    'A' => 2, 'B' => 1, 'C' => 2, 'D' => 2, 'E' => 2, 'F' => 1,
                                  'D+'=> 6,
  }
);


1;