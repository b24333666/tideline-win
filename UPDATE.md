# GitHub 更新步驟

倉庫:`b24333666/tideline-win`(main 分支)

---

## ⚠️ 先做:金鑰檢查

你本機的 `.data/keys.json` 裡有一把 Tiingo token。**`.gitignore` 已涵蓋它,正常不會被提交**,但請務必:

1. 若這把 token 目前仍有效 → 到 tiingo.com 撤銷並重新產一把(它曾在早期版本外流過)。
2. 推送前跑一次確認:

```bash
git status --porcelain | grep -i keys.json   # 應該沒有任何輸出
```

若有輸出就 **停下來**,先 `git rm --cached .data/keys.json`。

---

## 這次更新的內容

### 改動的檔案(全部在編譯產物內)

| 檔案 | 改了什麼 |
|---|---|
| `app/server.js` | 靜態資源快取修復(`no-cache, must-revalidate` + ETag),換版後不必再 Ctrl+Shift+R |
| `app/.next/static/chunks/app/page-7073cbe1d440fddf.js` | 前端主體:注入層(組態器/互動圖/報價/關注列表/三語)+ 原生修正(移除領域掃描分頁、9 處 null 防護) |
| `app/.next/server/app/api/custom/[symbol]/route.js` | 新增 `series_full`(全歷史日線,供互動圖) |
| `app/.next/server/app/api/screen/route.js` | 每列補 `last/asof/dif_pct/slope4/vol_ratio`(供報價分頁完整判定) |
| `app/.next/server/chunks/993.js` | HYPE 加密別名解析(`HYPE` → `HYPE-USD` → Yahoo `HYPE32196-USD`) |

### 新功能(已寫進 README)

- 當前報價分頁(264 檔 · 分領域 · 篩選排序 · 點代號跳自選)
- 關注列表分頁(自訂代號 + 自定義分類 · 存本機)
- 動法組態器(位置×階段衝突仲裁 · 六維成句 · 八種動法檢核)
- 互動價格圖(全歷史日線 · 縮放平移 · 狀態方框 · 轉變清單)
- 市場情緒週期(Wall St. 13 階段 · 一日晝夜 · 純顯示不參與裁決)
- 三語介面(繁 / 簡 / EN)

---

## 更新步驟

### 1. 取得最新倉庫

```bash
git clone https://github.com/b24333666/tideline-win.git
cd tideline-win
# 或已有 clone:
# cd tideline-win && git pull
```

### 2. 解壓新版並覆蓋

把 `tideline-win-patched.zip` 解開,然後用它的內容覆蓋倉庫:

```bash
# macOS / Linux
unzip -o ~/Downloads/tideline-win-patched.zip -d /tmp/tl-new
rsync -a --delete /tmp/tl-new/app/ ./app/
cp /tmp/tl-new/start.bat /tmp/tl-new/start.command ./
cp /tmp/tl-new/說明.txt ./ 2>/dev/null || true
```

```powershell
# Windows PowerShell
Expand-Archive -Force "$HOME\Downloads\tideline-win-patched.zip" "$env:TEMP\tl-new"
Remove-Item -Recurse -Force .\app
Copy-Item -Recurse "$env:TEMP\tl-new\app" .\app
Copy-Item -Force "$env:TEMP\tl-new\start.bat","$env:TEMP\tl-new\start.command" .
```

### 3. 套用本資料夾提供的檔案

把這個 `github-update/` 資料夾裡的檔案複製到倉庫根目錄:

- `README.md` — 已加入新功能說明(中英雙語)
- `.gitignore` — 補上 `app/.data/` 快取忽略規則
- `LICENSE` — **可選**,見下方說明

### 4. 確認要提交什麼

```bash
git status
git diff --stat
```

預期會看到:`app/.next/...` 幾個檔案、`README.md`、`.gitignore`。
**不該看到** `keys.json` 或 `.data/` 內的快取。

### 5. 提交並推送

```bash
git add -A
git commit -m "feat: 組態器/互動圖/報價/關注列表 + 三語介面;修快取與 null 崩潰

- 新增動法組態器:位置×階段衝突仲裁、六維成句、動法一致性檢核
- 新增互動價格圖:全歷史日線、縮放平移、狀態方框、轉變清單
- 新增市場情緒週期:Wall St. 13 階段(純顯示,不參與裁決)
- 新增當前報價分頁(264 檔)與關注列表分頁(自訂分類)
- 三語介面:繁體/簡體/English
- 修復:靜態資源快取標頭、9 處 null.toFixed 崩潰、HYPE 代號解析
- 移除:原生領域掃描分頁"
git push origin main
```

---

## 關於 LICENSE

倉庫目前**沒有授權條款**——這在法律上等同「保留所有權利」,別人不能合法使用或改作。

我附了一份 **MIT**(最寬鬆常見的選擇)。若要採用:

1. 打開 `LICENSE`,把 `[你的名字或 GitHub 帳號]` 換成你要署名的名字。
2. 複製到倉庫根目錄一起提交。

**這是你的決定,不是必須的。** 若你希望保留較多權利,可考慮 Apache-2.0(含專利條款)或乾脆不加(維持保留所有權利)。我不是律師,這只是常見做法的說明。

---

## 一個提醒

所有改動都在**編譯產物**裡。如果你之後拿到原始碼重新 build,這些改動會被覆蓋——屆時需要把功能移進源碼,或重新套用注入層。
