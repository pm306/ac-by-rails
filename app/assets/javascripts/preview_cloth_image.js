document.addEventListener("DOMContentLoaded", function() {
    initializeFileInput();
});

function initializeFileInput() {
    // input要素を見つけます
    let input = document.querySelector('input[type=file]');

    // input要素が変更された時のイベントリスナーを追加します
    input.addEventListener('change', function(e) {
        handleFileChange(e);
    });
}

function handleFileChange(e) {
    // 選択されたファイルを取得します
    let file = e.target.files[0];
    if (!file) {
        console.error('No file selected');
        return;
    }

    // 既存の画像を非表示にする
    let existingImage = document.querySelector('#existing-image');
    if (existingImage) {
        existingImage.style.display = 'none';
    }

    // FileReaderのインスタンスを作成します
    let reader = new FileReader();

    // ファイルが読み込まれたときのイベントリスナーを追加します
    reader.onload = function(e) {
        displayImage(e.target.result);
    };

    // エラーハンドリングを追加します
    reader.onerror = function() {
        console.error('Error occurred while reading the file');
    };

    // ファイルを読み込みます
    reader.readAsDataURL(file);
}

function displayImage(imageData) {
    // 画像を表示する要素を取得し、src属性を設定します
    let img = document.querySelector('#image-preview img');
    img.src = imageData;

    // 画像を表示状態にします
    document.getElementById('image-preview').style.display = 'block';
}
