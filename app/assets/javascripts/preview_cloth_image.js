document.addEventListener("DOMContentLoaded", function() {
    // input要素を見つけます
    let input = document.querySelector('input[type=file]');
    
    // input要素が変更された時のイベントリスナーを追加します
    input.addEventListener('change', function(e) {
    // 選択されたファイルを取得します
    let file = e.target.files[0];
    let reader = new FileReader();
    
    // ファイルが読み込まれたときのイベントリスナーを追加します
    reader.onload = function(e) {
        // 読み込まれたファイルのデータをsrc属性として画像にセットします
        let img = document.querySelector('#image-preview img');
        img.src = e.target.result;
        // 画像を表示状態にします
        document.getElementById('image-preview').style.display = 'block';
    };
    
    // ファイルを読み込みます
    reader.readAsDataURL(file);
    });
});
