# 潮位 TIDELINE

**長週期價格位置與階段判定框架 · A long-cycle price-position and phase-judgment framework**

[中文](#中文) · [English](#english)

---

## 中文

TIDELINE 以單一週線框架回答一個問題:**這個標的現在位於長週期的哪個階段,下一階段最可能往哪走。**

它以 5 年價格區間位置與 200 週均線界定「位置」,以週線 MACD(DIF/價格%)界定「動能」,將標的歸入六階段循環:

> 底部積累 → 上升初段 → 上升主段 → 高位派發 → 下降段 → 波段修復

並用該標的自身的歷史階段轉移做貝葉斯推演,輸出下一階段的後驗機率、加權期望值與歷史節奏統計。

### 功能

- **階段判定與推演** — 六階段循環定位、下一階段後驗機率、加權期望值、歷史節奏(各階段時長中位數與樣本數)
- **籌碼成本分布** — 由公開價量推估(52 週半衰期時間衰減),含買賣壓牆、供給/支撐帶與估計成本線
- **相對強度** — 對 ETH/BTC 或自訂基準的比值週期讀法,含比值 MACD 與背離標記
- **紅藍多空攻防** — 吸收/派發控盤轉換的時間序列
- **進出場條件梯** — 明確的觸發、失效與退出條件,附歷史基礎率
- **自動降階** — 史料不足 156 週時降階至 2 日線判定,並於頁面明確標示

### 快速開始(免安裝)

不需要預先安裝 Node.js,啟動器會自動下載可攜版執行環境(僅首次,約 30 MB)。

| 平台 | 操作 |
|---|---|
| Windows | 雙擊 `start.bat` |
| macOS | 執行 `start.command` |

瀏覽器會自動開啟 `http://localhost:3000`。

### 資料來源

- 股票與 iShares ETF:Yahoo Finance / Tiingo / Stooq / Nasdaq
- 加密貨幣:Binance / CryptoCompare / Coinbase
- Tiingo 為選用資料源;如需啟用,在 `.data/keys.json` 放入你自己的金鑰:`{"tiingo": "YOUR_KEY"}`(此檔已被 `.gitignore` 排除,請勿提交)

### 免責聲明

所有輸出為結構化證據與經驗頻率,**非投資建議**。成本分布由公開價量推估,非真實持股資料,無法識別持有者身分與意圖。小市值標的之下市與流動性風險不在本框架涵蓋範圍。

![image](https://github.com/b24333666/tideline-win/blob/main/home_ct.png)

---

## English

TIDELINE answers one question in a single weekly framework: **where does an asset sit in its long cycle, and where is the next phase most likely to go.**

Position is defined by 5-year range location and the 200-week moving average; momentum by weekly MACD (DIF as % of price). Each asset is mapped onto a six-phase cycle:

> bottom accumulation → early uptrend → main uptrend → topping/distribution → downtrend → recovery

Bayesian inference over the asset's own historical phase transitions yields posterior probabilities for the next phase, weighted expectancy, and cycle-tempo statistics.

### Features

- **Phase judgment and projection** — six-phase cycle mapping, next-phase posteriors, weighted expectancy, and tempo statistics (median phase durations with sample counts)
- **Estimated cost distribution** — inferred from public price/volume with a 52-week half-life decay; buy/sell pressure walls, supply and support bands, and an estimated-cost line
- **Relative strength** — ratio-cycle reading versus ETH/BTC or custom benchmarks, with ratio MACD and divergence markers
- **Red-blue tug-of-war** — a time series of absorption/distribution regime shifts
- **Entry/exit condition ladders** — explicit triggers, invalidation, and exit rules with historical base rates
- **Automatic downgrade** — with under 156 weeks of history, the judging frame downgrades to 2-day bars and says so on the page

### Quick start (zero-install)

No pre-installed Node.js required — the launcher downloads a portable runtime automatically (first run only, ~30 MB).

| Platform | Action |
|---|---|
| Windows | double-click `start.bat` |
| macOS | run `start.command` |

Your browser opens `http://localhost:3000` automatically.

### Data sources

- Equities and iShares ETFs: Yahoo Finance / Tiingo / Stooq / Nasdaq
- Crypto: Binance / CryptoCompare / Coinbase
- Tiingo is optional; to enable it, put your own key in `.data/keys.json` as `{"tiingo": "YOUR_KEY"}` (this file is git-ignored — never commit it)

### Disclaimer

All output is structured evidence and empirical frequency — **not investment advice**. The cost distribution is estimated from public price/volume, not actual holdings; it cannot identify holders or their intent. Delisting and liquidity risk of small-cap assets are outside this framework's scope.

![image](https://github.com/b24333666/tideline-win/blob/main/home_en.png)

