############# フォーム・アイテム #############
use strict;
#use warnings;
use utf8;
use open ":utf8";

my $LOGIN_ID = $::LOGIN_ID;

### 読込前処理 #######################################################################################
### 各種データライブラリ読み込み --------------------------------------------------
#require $set::data_item;

### データ読み込み ###################################################################################
my ($data, $mode, $file, $message) = pcDataGet($::in{'mode'});
our %pc = %{ $data };

my $mode_make = ($mode =~ /^(blanksheet|copy|convert)$/) ? 1 : 0;

### 出力準備 #########################################################################################
if($message){
  my $name = tag_unescape($pc{'itemName'} || '無題');
  $message =~ s/<!NAME>/$name/;
}
### 製作者名 --------------------------------------------------
if($mode_make && !$::make_error){
  $pc{'author'} = (getplayername($LOGIN_ID))[0];
}
### 初期設定 --------------------------------------------------
if($mode_make){ $pc{'protect'} = $LOGIN_ID ? 'account' : 'password'; }

### 改行処理 --------------------------------------------------
$pc{'effects'}     =~ s/&lt;br&gt;/\n/g;
$pc{'description'} =~ s/&lt;br&gt;/\n/g;


### フォーム表示 #####################################################################################
print <<"HTML";
Content-type: text/html\n
<!DOCTYPE html>
<html lang="ja">

<head>
  <meta charset="UTF-8">
  <title>@{[$mode eq 'edit'?"編集：$pc{'itemName'}":'新規作成']} - $set::title</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" media="all" href="${main::core_dir}/skin/_common/css/base.css?${main::ver}">
  <link rel="stylesheet" media="all" href="${main::core_dir}/skin/_common/css/sheet.css?${main::ver}">
  <link rel="stylesheet" media="all" href="${main::core_dir}/skin/sw2/css/item.css?{main::ver}">
  <link rel="stylesheet" media="all" href="${main::core_dir}/skin/_common/css/edit.css?${main::ver}">
  <link rel="stylesheet" media="all" href="${main::core_dir}/skin/sw2/css/edit.css?{main::ver}">
  <script src="${main::core_dir}/lib/edit.js?${main::ver}" defer></script>
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous">
  <script>
    window.onload = function() { nameSet('itemName'); }
    // 送信前チェック ----------------------------------------
    function formCheck(){
      if(form.itemName.value === ''){
        alert('名称を入力してください。');
        form.itemName.focus();
        return false;
      }
      if(form.protect.value === 'password' && form.pass.value === ''){
        alert('パスワードが入力されていません。');
        form.pass.focus();
        return false;
      }
    }
  </script>
</head>
<body>
  <script src="${main::core_dir}/skin/_common/js/common.js?${main::ver}"></script>
  <header>
    <h1>$set::title</h1>
  </header>

  <main>
    <article>
      <form id="item" name="sheet" method="post" action="./" enctype="multipart/form-data" onsubmit="return formCheck();">
      <input type="hidden" name="ver" value="${main::ver}">
      <input type="hidden" name="type" value="i">
HTML
if($mode_make){
  print '<input type="hidden" name="_token" value="'.token_make().'">'."\n";
}
print <<"HTML";
      <input type="hidden" name="mode" value="@{[ $mode eq 'edit' ? 'save' : 'make' ]}">
            
      <div id="header-menu">
        <h2><span></span></h2>
        <ul>
          <li class="button">
HTML
if($mode eq 'edit'){
print <<"HTML";
            <input type="button" value="複製" onclick="window.open('./?mode=copy&type=i&id=$::in{'id'}@{[  $::in{'backup'}?"&backup=$::in{'backup'}":'' ]}');">
HTML
}
print <<"HTML";
            <input type="submit" value="保存">
          </li>
        </ul>
      </div>

      <aside class="message">$message</aside>
      
      <section id="section-common">
      <div class="box" id="name-form">
        <div>
          <dl id="character-name">
            <dt>名称</dt>
            <dd>@{[ input('itemName','text',"nameSet('itemName')") ]}</dd>
          </dl>
        </div>
        <dl id="player-name">
          <dt>製作者</dt>
          <dd>@{[input('author')]}</dd>
        </dl>
      </div>
HTML
if($set::user_reqd){
  print <<"HTML";
    <input type="hidden" name="protect" value="account">
    <input type="hidden" name="protectOld" value="$pc{'protect'}">
    <input type="hidden" name="pass" value="$::in{'pass'}">
HTML
}
else {
  if($set::registerkey && $mode_make){
    print '登録キー：<input type="text" name="registerkey" required>'."\n";
  }
  print <<"HTML";
      <details class="box" id="edit-protect" @{[$mode eq 'edit' ? '':'open']}>
      <summary>編集保護設定</summary>
      <p id="edit-protect-view"><input type="hidden" name="protectOld" value="$pc{'protect'}">
HTML
  if($LOGIN_ID){
    print '<input type="radio" name="protect" value="account"'.($pc{'protect'} eq 'account'?' checked':'').'> アカウントに紐付ける（ログイン中のみ編集可能になります）<br>';
  }
    print '<input type="radio" name="protect" value="password"'.($pc{'protect'} eq 'password'?' checked':'').'> パスワードで保護 ';
  if ($mode eq 'edit' && $pc{'protect'} eq 'password') {
    print '<input type="hidden" name="pass" value="'.$::in{'pass'}.'"><br>';
  } else {
    print '<input type="password" name="pass"><br>';
  }
  print <<"HTML";
<input type="radio" name="protect" value="none"@{[ $pc{'protect'} eq 'none'?' checked':'' ]}> 保護しない（誰でも編集できるようになります）
      </p>
      </details>
HTML
}
  print <<"HTML";
      <dl class="box" id="hide-options">
        <dt>閲覧可否設定</dt>
        <dd id="forbidden-checkbox">
          <select name="forbidden">
            <option value="">内容を全て開示
            <option value="battle" @{[ $pc{'forbidden'} eq 'battle' ? 'selected' : '' ]}>データ・数値のみ秘匿
            <option value="all"    @{[ $pc{'forbidden'} eq 'all'    ? 'selected' : '' ]}>内容を全て秘匿
          </select>
        </dd>
        <dd id="hide-checkbox">
          <select name="hide">
            <option value="">一覧に表示
            <option value="1" @{[ $pc{'hide'} ? 'selected' : '' ]}>一覧には非表示
          </select>
        </dd>
        <dd>
          ※一覧に非表示でもタグ検索結果・マイリストには表示されます
        </dd>
      </dl>
      <div class="box" id="group">
        <dl>
          <dt>タグ</dt><dd>@{[ input 'tags' ]}</dd>
        </dl>
      </div>
      
      <div class="box input-data">
      <label>@{[ input 'magic', 'checkbox' ]}<span>魔法のアイテム</span></label>
      <!-- <label>@{[ input 'school', 'checkbox' ]}　流派装備</label> -->
      <hr>
      <dl><dt>基本取引価格</dt><dd>@{[ input 'price' ]}G</dd></dl>
      <dl><dt>知名度  </dt><dd>@{[ input 'reputation', 'text','','pattern="^[0-9\/／]+$"' ]} 数字と／のみ入力可</dd></dl>
      <dl><dt>形状    </dt><dd>@{[ input 'shape' ]}</dd></dl>
      <dl><dt>カテゴリ</dt><dd>@{[ input 'category','text','','list="list-category"' ]}
        複数カテゴリの場合、スペースで区切ってください。</dd></dl>
      <dl><dt>製作時期</dt><dd>@{[ input 'age','text','','list="list-age"' ]}</dd></dl>
      <dl><dt>概要    </dt><dd>@{[ input 'summary' ]}</dd></dl>
    </div>
    <div class="box">
      <h2>効果</h2>
      <textarea name="effects">$pc{'effects'}</textarea>
      <h4>武器データ</h4>
      <table class="input-weapon-data">
      <tr><th>用法</th><th>必筋</th><th>命中</th><th>威力</th><th>C値</th><th>追加D</th><th>備考</th></tr>
      <tr>
        <td>@{[ input 'weapon1Usage','text','','list="list-usage"' ]}</td>
        <td>@{[ input 'weapon1Reqd' ]}</td>
        <td>@{[ input 'weapon1Acc' ]}</td>
        <td>@{[ input 'weapon1Rate' ]}</td>
        <td>@{[ input 'weapon1Crit' ]}</td>
        <td>@{[ input 'weapon1Dmg' ]}</td>
        <td>@{[ input 'weapon1Note' ]}</td>
      </tr>
      <tr>
        <td>@{[ input 'weapon2Usage','text','','list="list-usage"' ]}</td>
        <td>@{[ input 'weapon2Reqd' ]}</td>
        <td>@{[ input 'weapon2Acc' ]}</td>
        <td>@{[ input 'weapon2Rate' ]}</td>
        <td>@{[ input 'weapon2Crit' ]}</td>
        <td>@{[ input 'weapon2Dmg' ]}</td>
        <td>@{[ input 'weapon2Note' ]}</td>
      </tr>
      <tr>
        <td>@{[ input 'weapon3Usage','text','','list="list-usage"' ]}</td>
        <td>@{[ input 'weapon3Reqd' ]}</td>
        <td>@{[ input 'weapon3Acc' ]}</td>
        <td>@{[ input 'weapon3Rate' ]}</td>
        <td>@{[ input 'weapon3Crit' ]}</td>
        <td>@{[ input 'weapon3Dmg' ]}</td>
        <td>@{[ input 'weapon3Note' ]}</td>
      </tr>
      </table>
      <p>
      <code>[刃]</code> <code>[打]</code> でそれぞれ<img class="i-icon" src="${set::icon_dir}wp_edge.png"><img class="i-icon" src="${set::icon_dir}wp_blow.png">に置き換え
      <p>
      <h4>防具データ</h4>
      <table class="input-armour-data">
      <tr><th>用法</th><th>必筋</th><th>回避</th><th>防護</th><th>備考</th></tr>
      <tr>
        <td>@{[ input 'armour1Usage','text','','list="list-usage"' ]}</td>
        <td>@{[ input 'armour1Reqd' ]}</td>
        <td>@{[ input 'armour1Eva' ]}</td>
        <td>@{[ input 'armour1Def' ]}</td>
        <td>@{[ input 'armour1Note' ]}</td>
      </tr>
      <tr>
        <td>@{[ input 'armour2Usage','text','','list="list-usage"' ]}</td>
        <td>@{[ input 'armour2Reqd' ]}</td>
        <td>@{[ input 'armour2Eva' ]}</td>
        <td>@{[ input 'armour2Def' ]}</td>
        <td>@{[ input 'armour2Note' ]}</td>
      </tr>
      <tr>
        <td>@{[ input 'armour3Usage','text','','list="list-usage"' ]}</td>
        <td>@{[ input 'armour3Reqd' ]}</td>
        <td>@{[ input 'armour3Eva' ]}</td>
        <td>@{[ input 'armour3Def' ]}</td>
        <td>@{[ input 'armour3Note' ]}</td>
      </tr>
      </table>
    </div>
    <div class="box">
      <h2>解説</h2>
      <textarea name="description">$pc{'description'}</textarea>
    </div>
    </section>
    
      @{[ input 'birthTime','hidden' ]}
      <input type="hidden" name="id" value="$::in{'id'}">
    </form>
HTML
if($mode eq 'edit'){
print <<"HTML";
    <form name="del" method="post" action="./" id="deleteform">
      <p style="font-size: 80%;">
      <input type="hidden" name="mode" value="delete">
      <input type="hidden" name="type" value="i">
      <input type="hidden" name="id" value="$::in{'id'}">
      <input type="hidden" name="pass" value="$::in{'pass'}">
      <input type="checkbox" name="check1" value="1" required>
      <input type="checkbox" name="check2" value="1" required>
      <input type="checkbox" name="check3" value="1" required>
      <input type="submit" value="シート削除"><br>
      ※チェックを全て入れてください
      </p>
    </form>
HTML
}
print <<"HTML";
    </article>
  </main>
  <footer>
    『ソード・ワールド2.5』は、「グループSNE」及び「KADOKAWA」の著作物です。<br>
    　ゆとシートⅡ for SW2.5 ver.${main::ver} - ゆとらいず工房
  </footer>
  <datalist id="list-usage">
    <option value="1H">
    <option value="1H#">
    <option value="1H投">
    <option value="1H拳">
    <option value="1H両">
    <option value="2H">
    <option value="2H#">
    <option value="振2H">
    <option value="突2H">
  </datalist>
  <datalist id="list-age">
    <option value="現在">
    <option value="魔動機文明">
    <option value="魔法文明">
    <option value="神紀文明">
    <option value="不明">
  </datalist>
  <datalist id="list-category">
    <option value="〈ソード〉">
    <option value="〈アックス〉">
    <option value="〈スピア〉">
    <option value="〈メイス〉">
    <option value="〈スタッフ〉">
    <option value="〈フレイル〉">
    <option value="〈ウォーハンマー〉">
    <option value="〈絡み〉">
    <option value="〈格闘〉">
    <option value="〈投擲〉">
    <option value="〈ボウ〉">
    <option value="〈クロスボウ〉">
    <option value="〈ガン〉">
    <option value="〈矢弾〉">
    <option value="〈非金属鎧〉">
    <option value="〈金属鎧〉">
    <option value="〈盾〉">
    <option value="装飾品：頭">
    <option value="装飾品：顔">
    <option value="装飾品：耳">
    <option value="装飾品：首">
    <option value="装飾品：背中">
    <option value="装飾品：手">
    <option value="装飾品：腰">
    <option value="装飾品：足">
    <option value="装飾品：その他">
    <option value="装飾品：任意">
    <option value="薬草類">
    <option value="ポーション類">
    <option value="冒険者技能用アイテム">
    <option value="楽器">
    <option value="特殊楽器">
    <option value="冒険道具類">
    <option value="冒険道具類（消耗品）">
  </datalist>
<script>
function view(viewId){
  let value = document.getElementById(viewId).style.display;
  document.getElementById(viewId).style.display = (value === 'none') ? '' : 'none';
}
</script>
</body>
</html>
HTML

1;