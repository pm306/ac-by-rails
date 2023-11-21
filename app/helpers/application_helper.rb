module ApplicationHelper

  # ページごとの完全なタイトルを返します。
  def full_title(page_title = '')
    base_title = "AutoCoordinator"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # pathへの「戻る」リンクを埋め込んだ画像を提供します。
  def back_link_to(path)
    link_to image_tag("sites/navigationj_back.png", class: "image-back-link"), path
  end
end
