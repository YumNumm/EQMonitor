# PMTiles展開budgetを実測で厳格化する

## 現状

既存のbase mapとseismicity archiveは分布値が保存されていないため、互換性を
壊さずgzip bombを有限化する暫定値として、directory encoded 1 MiB / decoded
8 MiB、tile encoded 4 MiB / decoded 16 MiBをcallerから明示している。

debug base mapは最大6 tileを並列処理するため、敵対archiveでは展開結果96 MiB、
圧縮入力24 MiBに加え、MVT decode isolateへのcopyとmesh allocationが重なり得る。

## 実施事項

- release対象のbase map / seismicity / estimated-intensity archiveについて、root、
  leaf、tileそれぞれのencoded/decoded byteのp50 / p95 / p99 / maxを記録する。
- iOS実機の6並列decodeでpeak RSSとmemory pressureを計測する。
- source別の上限を実測maxへ安全率を加えた値までtightenする。estimated sourceは
  generic暫定値を継承せず、descriptor/header契約に対応する独立値を持たせる。
- 同時展開の合計byteを制限するweighted permitをrepository/scheduler境界へ追加し、
  cancel・generation supersede・closeでpermitが必ず返却されることをtestする。

## 完了条件

known production archiveが上限内であるfixture/CI evidenceと、上限超過時にpartial
tileをpublishしない自動testがあり、6並列時のpeak RSSが対応端末budget内に収まる。
