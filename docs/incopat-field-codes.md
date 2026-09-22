# incoPat 官方字段代码表（原始字段代码说明）

> **来源**：官方帮助页「原始字段代码说明」<https://www.incopat.com/help/sysdoc/helpcode.html>（**需登录**）。
> 由维护者于 2026-09-22 下载该页面后提取（页面含静态表格 + `addHelpCodeHtml()` 动态生成的行，共 504 行）。
>
> 本表共 **504 行 / 468 个字段代码**。页面按功能分成 9 张表，此处按页面原始顺序合并。
> 其中有 **8 个字段（`PHC` 与 7 个 `*-DC`）只写在页面 HTML 注释里**，浏览器里看不到，
> 但数据库实测可用；详见 [`field-code-notes.md`](field-code-notes.md)。
>
> `syntax/incoPatSearchCriteria.vim` 里的 `scKEY` 白名单 = **本表 468 个 + `R` / `RAD` / `RPD`
> + 3 个数据库兼容的旧字段（`APNORTT` / `AEENORTT` / `PATENTEENORTT`）**，共 **474 个**。
> 白名单按本表顺序排列（那 3 个旧字段插在各自 `-NOR` 之后），因此可以随时按本文件重新生成或核对。
>
> **核对规则与「不要反复核实」的两组例外见 [`field-code-notes.md`](field-code-notes.md)。**

| # | 字段代码 | 字段名 | 英文名 | 检索样例 |
| --- | --- | --- | --- | --- |
| 1 | `ti` | 标题 | Title | ti=(发动机) |
| 2 | `ab` | 摘要 | Abstract | ab=(汽车) |
| 3 | `tiab-dwpi` | 标题摘要(含DWPI) | Title/Abstract with DWPI | tiab-dwpi=(发动机) 或 tiab-dwpi=(engine) |
| 4 | `claim` | 权利要求 | Claim | claim=(发动机) |
| 5 | `ipc` | IPC分类 | IPC | ipc=(A61L27/38) |
| 6 | `loc` | 洛迦诺分类 | Locarno Classification | loc=(12-08) |
| 7 | `an` | 申请号 | Application Number | an=(CN201010196166) |
| 8 | `rand-DWPI` | DWPI相关专利申请号 | Related Application Number-DWPI | rand-DWPI=(CN202180000150.3) |
| 9 | `ad` | 申请日 | Application Date | ad=(20080808) |
| 10 | `pn` | 公开(公告)号 | Publication Number | pn=(CN1942853A) |
| 11 | `pd` | 公开(公告)日 | Publication Date | pd=(20110104) 或 pd=(2011*) 或pd=[20110101 to 20130101] |
| 12 | `ap-lite` | 申请人(基础) | Applicant(Basic) | ap-lite=(清华大学) |
| 13 | `ap` | 申请人 | Applicant | ap=(中兴) |
| 14 | `ap-group` | 申请人(多语种) | Applicant(Multilingual) | ap-group=(清华大学) |
| 15 | `ap-grouptt` | 申请人(多语种)(精确匹配) | Applicant(Multilingual)(Exact Match) | ap-grouptt=(清华大学) |
| 16 | `AP-ALL` | 申请人(全) | All Applicant | AP-ALL=中兴 |
| 17 | `aee` | 受让人 | Assignee | aee=(戴尔) |
| 18 | `ap-add` | 申请人地址 | Applicant Address | ap-add=(北京市西城区) |
| 19 | `ap-country` | 申请人国别 | Applicant Country | ap-country=(CN) |
| 20 | `in` | 发明(设计)人 | Inventor | in=(邱则有) |
| 21 | `in-DWPI` | DWPI发明人 | Inventor - DWPI | in-DWPI=(Bethea C G) |
| 22 | `lor` | 许可人 | Licensor | lor=(清华大学) |
| 23 | `lee` | 被许可人 | Licensee | lee=(联想) |
| 24 | `lg` | 法律状态文字信息 | Legal Status in Text | lg=(联想) |
| 25 | `ri-text` | 复审无效全文 | Reexamination/Invalidation Fulltext | ri-text=(豆浆机) |
| 26 | `status` | 专利有效性 | Patent Status | status=(审中 or 有效) |
| 27 | `lgi-party` | 诉讼当事人 | Legal Party | lgi-party=(邱则有) |
| 1 | `ti` | 标题 | Title | ti=(发动机) |
| 2 | `ti-cn` | 标题-中文 | Title (Chinese) | ti-cn= (发动机) |
| 3 | `ti-otlang` | 标题-小语种 | Title (Other Language) | ti-otlang=("브이형 내연기관의 엔진 블록용 호닝가공 장치") |
| 4 | `ti-en` | 标题-英文 | Title(English) | ti-en=(engine) |
| 5 | `ti-dwpi` | DWPI标题 | DWPI Title | ti-dwpi=(发动机) 或 ti-dwpi=(engine) |
| 6 | `ab` | 摘要 | Abstract | ab= (汽车) |
| 7 | `ab-cn` | 摘要-中文 | Abstract (Chinese) | ab-cn= (发动机) |
| 8 | `ab-otlang` | 摘要-小语种 | Abstract (Other Language) | ab-otlang=("couche de vernis") |
| 9 | `ab-en` | 摘要-英文 | Abstract (English) | ab-en=(engine) |
| 10 | `use-dwpi` | DWPI用途 | DWPI Use | use-dwpi=(手机) 或 use-dwpi=(phone) |
| 11 | `adv-dwpi` | DWPI优势 | DWPI Advantage | adv-dwpi=(结构简单) 或 adv-dwpi=(simple structure) |
| 12 | `novelty-dwpi` | DWPI新颖性 | DWPI Novelty | novelty-dwpi=(发动机) 或 novelty-dwpi=(engine) |
| 13 | `abstract-dwpi` | DWPI摘要 | DWPI Abstract | abstract-dwpi=(发动机) 或 abstract-dwpi=(engine) |
| 14 | `DTD-DWPI` | DWPI详细描述 | DWPI Detailed Description | DTD-DWPI=(抗抑郁药 OR 扫描仪) |
| 15 | `ACTIVITY-DWPI` | DWPI生物活性 | DWPI ACTIVITY | ACTIVITY-DWPI=(抗抑郁药 OR 扫描仪) |
| 16 | `MEC-DWPI` | DWPI生物学机制 | DWPI MechanismOfAction | MEC-DWPI=(组胺H3 AND (受体 OR 拮抗剂)) |
| 17 | `FOC-DWPI` | DWPI技术要点 | DWPI Technology Focus | FOC-DWPI=(聚合物) |
| 18 | `DRAW-DWPI` | DWPI附图说明 | DWPI Drawing Description | DRAW-DWPI=(机器人) |
| 19 | `tiab` | 标题摘要 | Title/Abstract | tiab=(发动机) |
| 20 | `tiab-dwpi` | 标题摘要(含DWPI) | Title/Abstract with DWPI | tiab-dwpi=(发动机) 或 tiab-dwpi=(engine) |
| 21 | `claim` | 权利要求 | Claim | claim=(发动机) |
| 22 | `first-claim` | 首项权利要求 | first-claim | first-claim=(一种信息显示方法) |
| 23 | `first-claim-cn` | 首项权利要求(中文) | First Claim (Chinese) | first-claim-cn="一种微结构化膜” |
| 24 | `first-claim-en` | 首项权利要求(英文) | First Claim (English) | first-claim-en="tempered glass screen” |
| 25 | `first-claim-ot` | 首项权利要求(其他) | First Claim (Minor Language) | first-claim-ot="強化ガラス” |
| 26 | `indepclaims-cn` | 独立权利要求 | independent claim | indepclaims-cn=(发动机) |
| 27 | `depclaims-cn` | 从属权利要求 | dependent claim | depclaims-cn=(发动机) |
| 28 | `no-indepclaims` | 独立权利要求数量 | Number of independent claims | no-indepclaims=2 或 no-indepclaims=[3 to 5] |
| 29 | `no-depclaims` | 从属权利要求数量 | Number of dependent claims | no-depclaims=8 或 no-depclaims=[3 to 5] |
| 30 | `first-claim-en` | 首项权利要求-英文 | First Claim (English) | first-claim-en="One micro structured films" |
| 30 | `len-first-claim` | 首权字数 | First Claim (Word Count) | len-first-claim=105 或 len-first-claim=[150 to 230] |
| 31 | `Claim-EN` | 权利要求-英文 | Claim in English | claim-EN=(engine) |
| 32 | `Claim-CN` | 权利要求-中文 | Claim in Chinese | claim-CN=(发动机) |
| 33 | `Claim-OT` | 权利要求-其他语言 | Claim in Other Language | claim-OT=(Moteur) |
| 34 | `no-claim` | 权利要求数量 | Claim Number | no-claim=(10) |
| 35 | `tiabc` | 标题摘要权利要求 | Title/Abstract/Claim | tiabc=(发动机) |
| 36 | `des` | 说明书 | Description | des=(发动机) |
| 37 | `des-ot` | 说明书-其他语言 | Description (Other Language) | des-ot="Écran tactile" |
| 38 | `des-en` | 说明书英文翻译 | Description in English | des-en=container |
| 39 | `des-cn` | 说明书-中文 | Description in Chinese | des-cn=触控面板 |
| 40 | `technical-field` | 说明书技术领域 | Technical Field | technical-field=触控板 |
| 41 | `background-art` | 说明书背景技术 | Background Art | background-art=触控面板 |
| 42 | `disclosure` | 说明书发明内容 | Disclosure | DISCLOSURE=布线工艺 |
| 43 | `mode-for-invention` | 说明书具体实施方式 | Mode For Invention | mode-for-invention=剥膜 |
| 44 | `no-image` | 附图个数 | Number of images | no-image=3 |
| 45 | `effect-s-cn` | 技术功效句 | Technical Effect Sentence | effect-s-cn =(检测错误率减小) |
| 46 | `effect-ph-cn` | 技术功效短语 | Technical Effect Phrase | effect-ph-cn=(检测错误率减小) |
| 47 | `effect-cn` | 技术功效 | Technical Effect | effect-cn=(检测错误率减小) |
| 48 | `effect-cn-3` | 技术功效3级 | Technical Effect-3 | effect-cn-3=(检测准确性提高) |
| 49 | `effect-cn-2` | 技术功效2级 | Technical Effect-2 | effect-cn-2=(准确性提高) |
| 50 | `effect-cn-1` | 技术功效1级 | Technical Effect-1 | effect-cn-1=(准确性) |
| 51 | `effect-triz` | 技术功效TRIZ参数 | Technical Effect-TRIZ | effect-triz=01 |
| 52 | `all` | 主要著录信息 | Main Bibliographic Field | all=(发动机) |
| 53 | `full` | 全文 | Title/Abstract/Claim/Description | full=(发动机) |
| 54 | `filing-lang` | 申请语言 | Filing Language | filing-lang=(eng) |
| 55 | `prd-flag` | 优先权标签 | Priority Flag | prd-flag=(1) |
| 56 | `prd` | 优先权信息 | Prority | prd=(20090126)或者prd=( US10338820) |
| 57 | `PRD-DWPI` | DWPI优先权信息 | DWPI Prority Data | PRD-DWPI=(20100212)或者prd=(US10338820) |
| 58 | `page` | 文献页数 | Page | page=(100) 或 page=[001 to 200] |
| 59 | `vlstar` | 合享价值度 | Patent Value | vlstar=9 或 vlstar=[5 to 9] |
| 60 | `vlstar-1` | 技术稳定性 | Technology Stability | vlstar-1=9 或 vlstar-1=[5 to 9] |
| 61 | `vlstar-2` | 技术先进性 | Technology Advancement | vlstar-2=9 或 vlstar-2=[5 to 9] |
| 62 | `vlstar-3` | 保护范围 | Protection Scope | vlstar-3=9 或 vlstar-3=[5 to 9] |
| 63 | `reward-level` | 奖励等级 | Reward Level | reward-level=(中国专利奖金奖) |
| 64 | `reward-name` | 奖励名称 | Reward Name | reward-name=(中国专利奖) |
| 65 | `reward-session` | 奖励届次 | Reward Session | reward-session=(第1届中国专利奖) |
| 66 | `std-type` | 标准类型 | Standard type | std-type=ETSI |
| 67 | `std-Project` | 标准项目 | Standard project | std-Project=ITU_G9807_1-01 |
| 68 | `std-num` | 标准号 | Standard No. | std-num=("TS 29 212") |
| 69 | `std-company` | 公司（标准） | Company (Standard) | std-company=MOTOROLA Inc |
| 70 | `std-flag` | 标准专利标签 | Standard Patent Flag | std-flag=1 |
| 71 | `cas-no` | FDA-CAS号 | FDA-CAS Number | cas-no="610309-89-2" |
| 72 | `drug-name-cn` | FDA-中文名称 | FDA-Drug Name in Chinese | drug-name-cn=磷酸卡维地洛 |
| 73 | `drug-name-en` | FDA-英文名称 | FDA-Drug Name in English | drug-name-en="Carvedilol phosphate" |
| 74 | `company` | FDA-公司名称 | FDA-Company Name | company="SMITHKLINE BEECHAM (CORK) LTD IRELAND" |
| 75 | `Brand-Name` | FDA-商品名 | FDA-Brand Name | brand-name="Adrenaclick*" |
| 76 | `active-ingredient` | FDA-活性成分 | FDA-Active Ingredient | active-ingredient="MAGNESIUM HYDROXIDE" |
| 77 | `Target` | FDA-靶点 | FDA-Target | target="Beta-1 adrenergic receptor, Adrenergic receptor alpha-1" |
| 78 | `indication` | FDA-适应症 | FDA-Indication | indication="心房颤动, 慢性心绞痛" |
| 79 | `patent-expiration` | FDA-专利到期日 | FDA-Patent Expiration | patent-expiration=20250911 |
| 80 | `PED-patent-expiration` | FDA-PED药物专利到期日 | FDA-PED Patent Expiration | ped-patent-expiration=20260311 |
| 1 | `ap-or` | 申请人(原始) | Applicant(original) | ap-or="SOLIMAN SAMIR S." |
| 2 | `ap-ot` | 申请人(其他) | Applicant(Other Language) | ap-ot=(清华大学) |
| 3 | `ap-ts` | 申请人(翻译) | Applicant(Chinese) | ap-ts=(PANASONIC) |
| 4 | `ap-lite` | 申请人(基础) | Applicant(Basic) | ap-lite=(清华大学) |
| 5 | `ap` | 申请人 | Applicant | ap=(中兴) |
| 6 | `aptt` | 申请人(精确匹配) | Applicant(Exact Match) | aptt=(清华大学) |
| 7 | `ap-group` | 申请人(多语种) | Applicant(Multilingual) | ap-group=(清华大学) |
| 8 | `ap-grouptt` | 申请人(多语种)(精确匹配) | Applicant (Multilingual) (Exact Match) | ap-grouptt=(清华大学) |
| 9 | `AP-ALL` | 申请人(全) | All Applicant | AP-ALL=中兴 |
| 10 | `apnor` | 标准申请人 | Normalized Applicant | apnor=(中国移动-C) |
| 11 | `ap-root` | 申请人终属母公司 | applicant ultimate parent | ap-root=(百度控股有限公司) |
| 12 | `ap-first` | 第一申请人 | First Applicant | ap-first=“通用电气公司” |
| 13 | `ap-new-name` | 专利权人（申请人）变更后名称 | Changed Name of Patentee（Applicant) | ap-new-name=华为 |
| 15 | `ap-otadd` | 除中文外，其他语言申请人地址 | Applicant Address (Other Language) | ap-otadd=(北京) |
| 14 | `no-ap` | 申请人数量 | Applicant Number | no-ap=3 |
| 15 | `who` | 公司名和人名 | Company & Person Name | who=(清华大学) |
| 16 | `patentee` | 当前权利人 | Current Patentee | patentee=(三一汽车) |
| 17 | `patenteett` | 当前权利人(精确匹配) | Patentee(Exact Match) | patenteett=华为 |
| 18 | `patenteenor` | 标准化当前权利人 | Normalized Current Patentee | patenteenor=(华为) |
| 19 | `assign-party` | 转让或受让人 | Assignment Party | assign-party=(戴尔) |
| 20 | `aor` | 转让人 | Assignor | aor=(飞利浦) |
| 21 | `AOR-TYPE` | 转让人类型 | Type of assignor | AOR-TYPE=C |
| 22 | `aee` | 受让人 | Assignee | aee=(戴尔) |
| 23 | `aeett` | 受让人(精确匹配) | Assignee(Exact Match) | aeett=华为 |
| 24 | `aeenor` | 标准受让人 | Normalized Assignee | aeenor=（中国移动-c) |
| 25 | `AEE-TYPE` | 受让人类型 | Type of assignee | AEE-TYPE=C |
| 26 | `in` | 发明(设计)人 | Inventor | in=(邱则有) |
| 27 | `intt` | 发明（设计）人（精确匹配） | Inventor/Designer(Exact Match) | intt=(刘洋) |
| 28 | `in-or` | 发明(设计)人(原始) | Inventor/Designer (English) | in-or=(于崇) |
| 29 | `in-ot` | 发明(设计)人(其他) | Inventor/Designer (Other Language) | in-ot=(于崇) |
| 30 | `in-ts` | 发明(设计)人(翻译) | Inventor/Designer (Chinese) | in-ts=(king) |
| 31 | `in-first` | 第一发明(设计)人 | First Inventor/Designer | in-first=(于崇) |
| 32 | `no-in` | 发明(设计)人数量 | Inventor/Designer Number | no-in=3 |
| 33 | `in-new-name` | 发明人变更后名称 | Inventor Name After Changing | in-new-name=(于崇) |
| 34 | `in-current` | 当前发明人名称 | Current Inventor Name | in-current=(于崇) |
| 35 | `lor` | 许可人 | Licensor | lor=(清华大学) |
| 36 | `lee` | 被许可人 | Licensee | lee=(联想) |
| 37 | `LOR-TYPE` | 许可人类型 | Type of licensor | LOR-TYPE=C |
| 38 | `LEE-TYPE` | 被许可人类型 | Type of licensee | LEE-TYPE=C |
| 39 | `opponent` | 异议方 | opponent | opponent=“UMICORE AG CO KG” |
| 40 | `at` | 代理人姓名 | Attorney | at=(刘新宇) |
| 41 | `agc` | 代理机构 | Agency | agc=(柳沈) |
| 42 | `lgi-party` | 诉讼当事人 | Legal Party | lgi-party=(邱则有) |
| 43 | `re-ap` | 复审请求人 | Reexamination Applicant | re-ap=(联想) |
| 44 | `in-ap` | 无效请求人 | Invalidation Applicant | in-ap=(通用) |
| 45 | `ri-me` | 复审无效主审员 | Reexamination-invalidation Main Examiner | ri-me=(刘路尧) |
| 46 | `ri-ae` | 复审无效参审员 | Reexamination-invalidation Assitant Examiner | ri-ae=(崔宪丽) |
| 47 | `ri-leader` | 复审无效合议组组长 | Reexamination-invalidation Panel Leader | ri-leader=(张琳) |
| 48 | `por` | 出质人 | Pledgor | por=(电信科学技术研究院) |
| 49 | `pee` | 质权人 | Pledgee | pee=(国家开发银行) |
| 50 | `ex` | 审查员 | Examiner | ex=(张伟) |
| 51 | `ap-type` | 申请人类型 | Applicant Type | ap-type=(C) |
| 52 | `Patentee-Type` | 当前权利人类型 | Patentee-Type | Patentee-Type=C |
| 53 | `CO-DWPI` | DWPI专利权人/申请人 | Assignee/Applicant-DWPI | CO-DWPI=(Campitello R) |
| 54 | `ck-DWPI` | DWPI专利权人代码 | Assignee Code-DWPI | ck-DWPI=(SONY-C) |
| 55 | `CK-TYPE-DWPI` | 专利权人类型 - DWPI | Assignee Code Type-DWPI | CK-TYPE-DWPI=(N) |
| 56 | `ap-as` | 工商别名 | Business-DBA | ap-as=深圳市中兴通讯股份有限公司 |
| 57 | `ap-en` | 工商英文名 | Business-Registered Name (English) | ap-en=“Chongqing Yunhe Group Hydropower Equipment Company” |
| 58 | `ap-reg-location` | 工商注册地址 | Business-Registered Address | ap-reg-location=江苏省连云港 |
| 59 | `ap-company-org-type` | 工商公司类型 | Business-Company Type | ap-company-org-type=有限责任公司 |
| 60 | `ap-estiblish-time` | 工商成立日期 | Business-Company Establishment Time | ap-estiblish-time=20160712 |
| 61 | `ap-usc` | 工商统一社会信用代码 | Business-Uniform Social Credit Code | ap-usc=914403001922038216 |
| 62 | `ap-reg-number` | 工商注册号 | Business-Company Register Number | ap-reg-number=440301103852869 |
| 63 | `ap-reg-status` | 工商企业状态 | Business-Company Status | ap-reg-status=存续 |
| 64 | `ap-list-code` | 工商上市代码 | Business-Company List Code | ap-list-code=600031 |
| 1 | `ipc` | IPC分类 | IPC | ipc=(A61L27/38) |
| 2 | `ipc-main` | IPC主分类 | IPC Main | ipc-main=(A61K31/44) |
| 3 | `ipc-section` | IPC分类-部 | IPC Section | ipc-section=(F) |
| 4 | `ipc-class` | IPC分类-大类 | IPC Class | ipc-class=(F28) |
| 5 | `ipc-subclass` | IPC分类-小类 | IPC Subclass | ipc-subclass=(F28C) |
| 6 | `ipc-group` | IPC分类-大组 | IPC Group | ipc-group=(F28C1) |
| 7 | `IPCM-Section` | IPC主分类-部 | IPC Main Section | IPCM-Section=(F) |
| 8 | `IPCM-Class` | IPC主分类-大类 | IPC Main Class | IPCM-Class=(F28) |
| 9 | `IPCM-Subclass` | IPC主分类-小类 | IPC Main Subclass | IPCM-Subclass=(F28C) |
| 10 | `IPCM-Group` | IPC主分类-大组 | IPC Main Group | IPCM-Group=(F28C1) |
| 11 | `ipc-subgroup` | IPC分类-小组 | IPC Subgroup | ipc-subgroup=(F28D9/00) |
| 12 | `ipc-low` | IPC所有下位点组 | IPC Low | ipc-low=(A01B13/00) |
| 13 | `ipc-high` | IPC所有上位点组 | IPC High | ipc-high=(A01B13/10) |
| 14 | `IPCM-Low` | IPC主分类所有下位点组 | IPCM Low | IPCM-Low=(A01B13/00) |
| 15 | `IPCM-High` | IPC主分类所有上位点组 | IPCM High | IPCM-High=(A01B13/10) |
| 16 | `IPC-DWPI` | DWPI现版IPC分类号 | DWPI Current IPC classification | IPC-DWPI=(H04H20/12) |
| 17 | `IPC-Section-dwpi` | DWPI现版IPC分类号-部 | IPC Section f-DWPI | IPC-Section-dwpi=(H) |
| 18 | `IPC-Class-dwpi` | DWPI现版IPC分类号-大类 | IPC Class f-DWPI | IPC-Class-dwpi=(H04) |
| 19 | `loc` | 洛迦诺分类 | Locarno Classification | loc=(12-08) |
| 20 | `IPC-Subclass-DWPI` | DWPI现版IPC分类号-小类 | IPC Subclass f-DWPI | IPC-Subclass-DWPI=(H04H) |
| 21 | `IPC-GROUP-dwpi` | DWPI现版IPC分类号-大组 | IPC Class Group DWPI | IPC-GROUP-dwpi=(H04H20) |
| 22 | `IPC-Subgroup-DWPI` | DWPI现版IPC分类号-小组 | IPC Subgroup f-DWPI | IPC-Subgroup-DWPI=(H04H20/12) |
| 23 | `IPC-f-DWPI` | DWPI同族的IPC分类号 | IPC classification of DWPI Family | IPC-f-DWPI=(H04H20/12) |
| 24 | `IPC-Section-f-dwpi` | DWPI同族的IPC分类号-部 | IPC classification of DWPI Family-subclass | IPC-Section-f-dwpi=(H04H) |
| 25 | `IPC-Class-f-dwpi` | DWPI同族的IPC分类号-大类 | IPC classification of DWPI Family-Section | IPC-Class-f-dwpi=(H) |
| 26 | `IPC-Subclass-f-DWPI` | DWPI同族的IPC分类号-小类 | IPC classification of DWPI Family-group | IPC-Subclass-f-DWPI=(H04H20) |
| 27 | `IPC-GROUP-f-dwpi` | DWPI同族的IPC分类号-大组 | IPC classification of DWPI Family-class | IPC-GROUP-f-dwpi=(H04) |
| 28 | `IPC-Subgroup-f-DWPI` | DWPI同族的IPC分类号-小组 | IPC classification of DWPI Family-subgroup | IPC-Subgroup-f-DWPI=(H04H20/12) |
| 29 | `DC-DWPI` | DWPI分类号 | DWPI Classification | DC-DWPI=(K01) |
| 30 | `DC-SECTION-DWPI` | DWPI分类号-部 | DWPI Classification-sections | DC-SECTION-DWPI=(K) |
| 31 | `DC-CLASS-DWPI` | DWPI分类号-大类 | DWPI Classification-class | DC-CLASS-DWPI=(K01) |
| 32 | `MC-DWPI` | DWPI手工代码 | DWPI ManualCodes | MC-DWPI=(X22-C01) |
| 33 | `MC-section-DWPI` | DWPI手工代码-部 | DWPI ManualCodes-Section | MC-section-DWPI=A |
| 34 | `MC-class-DWPI` | DWPI手工代码-大类 | DWPI ManualCodes-Class | MC-class-DWPI=A01 |
| 35 | `MC-group-DWPI` | DWPI手工代码-组 | DWPI ManualCodes-group（Generic Manual Code) | MC-group-DWPI=A01-A |
| 36 | `MC-subgroup-DWPI` | DWPI手工代码-小组 | DWPI ManualCodes-Sub-group | MC-subgroup-DWPI=A01-A01 |
| 37 | `MC-subgroupd-DWPI` | DWPI手工代码-小组分支 | DWPI ManualCodes-Sub-group division | MC-subgroupd-DWPI=A01-D10A |
| 38 | `MC-fullmc-DWPI` | DWPI手工代码-级 | DWPI ManualCodes-Full Manual Code | MC-fullmc-DWPI=A02-A06E1 |
| 39 | `MC-fullmcx-DWPI` | DWPI手工代码-次级 | DWPI ManualCodes-Full Manual Code-x | MC-fullmcx-DWPI=S01-E02A8X |
| 40 | `loc-class` | 洛迦诺分类大类 | Locarno Class | loc-class=(12) |
| 41 | `loc` | 洛迦诺分类 | Locarno Classification | loc=(12-08) |
| 42 | `loc-subclass` | 洛迦诺分类小类 | Locarno Subclass | loc-subclass=（12-08） |
| 43 | `ecla` | 欧洲EC分类 | ECLA | ecla=(A61L27/38B6) |
| 44 | `ecla-section` | 欧洲EC分类-部 | ECLA Section | ecla-section=(A) |
| 45 | `ecla-class` | 欧洲EC分类-大类 | ECLA Class | ecla-class=(A61) |
| 46 | `ecla-subclass` | 欧洲EC分类-小类 | ECLA Subclass | ecla-subclass=(A61L) |
| 47 | `ecla-group` | 欧洲EC分类-大组 | ECLA Group | ecla-group=(A61L27) |
| 48 | `ecla-subgroup` | 欧洲EC分类-小组 | ECLA Subgroup | ecla-subgroup=(A61L27/38) |
| 49 | `uc` | 美国UC分类 | UC | uc=(623/23.64) |
| 50 | `uc-main` | 美国主UC分类 | UC Main | uc-main=(623/23.64) |
| 51 | `cpc` | CPC分类 | CPC | CPC=(A61B17/0057) |
| 52 | `cpc-section` | CPC分类-部 | CPC Section | cpc-section=(H) |
| 53 | `cpc-class` | CPC分类-大类 | CPC Class | cpc-class=(A61) |
| 54 | `cpc-subclass` | CPC分类-小类 | CPC Subclass | cpc-subclass=(A61B) |
| 55 | `cpc-group` | CPC分类-大组 | CPC Group | cpc-group=(A61B17) |
| 56 | `cpc-subgroup` | CPC分类-小组 | CPC Subgroup | cpc-subgroup=(A61B17/00) |
| 57 | `fi` | 日本fi分类 | FI Classification | fi=(H04L1/00) |
| 58 | `ft` | 日本fterm分类 | F-terms Classification | ft=(2D061/BA01) |
| 59 | `Class` | 分类号 | Classfication Number | class=(B60B35/02) |
| 60 | `phc` | 中国范畴分类 | China Patent Category Classification | phc=11B |
| 60 | `bclas1` | 国民经济行业门类 | National Economy Industry Classification-Catogory | bclas1=(C) |
| 61 | `bclas2` | 国民经济行业大类 | National economy industry classification-class | bclas2=(C39) |
| 62 | `bclas3` | 国民经济行业中类 | National Economy Industry Classification-MiddleClass | bclas3=(C352) |
| 63 | `bclas4` | 国民经济行业小类 | National economy industry classification-subclass | bclas4=(C3525) |
| 64 | `cpc-main` | CPC主分类号 | CPC Main | cpc-main=(A61B17/0057) |
| 65 | `cpcm-section` | CPC主分类-部 | CPC Main-section | cpcm-section=(H) |
| 66 | `cpcm-class` | CPC主分类-大类 | CPC Main-class | cpcm-class=(A61) |
| 67 | `cpcm-subclass` | CPC主分类-小类 | CPC Main-subclass | cpcm-subclass=(A61B) |
| 68 | `cpcm-group` | CPC主分类-大组 | CPC Main-group | cpcm-group=(A61B17) |
| 69 | `cpcm-subgroup` | CPC主分类-小组 | CPC Main-subgroup | cpcm-subgroup=(A61B17/00) |
| 70 | `industry1` | 新兴产业门类 | Category of emerging industries | industry1=(1) |
| 71 | `industry2` | 新兴产业大类 | Class of emerging industries | industry2=(1.1) |
| 1 | `ap-country` | 申请人国别 | Applicant Country | ap-country=(CN) |
| 2 | `in-country` | 发明人国别 | Inventor Country | in-country=(us) |
| 3 | `auth` | 专利申请的国别/组织/地区 | Application Authority | auth=(US) |
| 4 | `pnc` | 公开国别 | Publication Authority | pnc=(US) |
| 5 | `ap-add` | 申请人地址 | Applicant Address | ap-add=(北京市西城区) |
| 6 | `ap-oradd` | 申请人地址(原始) | Applicant Address (Original Language) | ap-oradd=北京 |
| 7 | `ap-tsadd` | 申请人地址(英文) | Applicant Address(English) | ap-tsadd=beijing |
| 8 | `ap-otadd` | 申请人地址(其他) | Applicant Address (Other Language) | ap-otadd=(北京) |
| 9 | `pr-au` | 优先权国别 | Priority Authority | pr-au=(US) |
| 10 | `pr-au-DWPI` | DWPI优先权国别 | Priority Country/Region-DWPI | pr-au-DWPI=(US or CN) |
| 11 | `ORIPRC-DWPI` | DWPI优先权国别-最早 | Priority Country/Region-Earliest-DWPI | ORIPRC-DWPI=(CN) |
| 12 | `ap-province` | 申请人省市 | Applicant Province | ap-province=(11) 或 ap-province=(北京) |
| 13 | `pc-cn` | 中国省市代码 | China Province Code | pc-cn=11 |
| 14 | `ap-pc` | 中国申请人省市代码 | Chinese Applicant-Province Code | ap-pc=11 |
| 15 | `city` | 中国申请人地市 | Chinese Applicant-City | city=(北京) 或 city=(桂林) |
| 16 | `county` | 中国申请人区县 | Chinese Applicant-County | county=(曲阜) 或 county=(越秀) |
| 17 | `PATENTEE-ADD` | 当前专利权人地址 | Patentee Address | PATENTEE-ADD=北京市西城 |
| 18 | `PATENTEE-PROVINCE` | 当前专利权人省市 | Patentee Province | PATENTEE-PROVINCE=北京 |
| 19 | `PATENTEE-CITY` | 当前专利权人地市 | Patentee City | PATENTEE-CITY=北京 |
| 20 | `PATENTEE-COUNTY` | 当前专利权人区县 | Patentee County | PATENTEE-COUNTY=曲阜 或 PATENTEE-COUNTY=越秀 |
| 21 | `in-add` | 发明人地址 | Inventor Address | in-add=(newyork) |
| 22 | `in-oradd` | 发明人地址（原始） | Inventor Address(Original Language) | in-oradd=(beijing) |
| 23 | `in-tsadd` | 发明人地址(英文) | Inventor Address(English) | in-tsadd=(beijing) |
| 24 | `in-otadd` | 发明人地址（其他） | Inventor Address(Other Language) | in-otadd=(RO) |
| 25 | `in-city` | 发明人城市 | Inventor City | in-city=(newyork) |
| 26 | `in-state` | 发明人所在州 | Inventor state | in-state=(tn) |
| 27 | `assign-country` | 受让人国别 | Assignee Country | assign-country=(CN OR US ) |
| 28 | `assignee-add` | 受让人地址 | Assignee Address | assignee-add=(北京 OR CHICAGO) |
| 29 | `assignee-cadd` | 当前受让人地址 | Current Assignee Address | assignee-cadd=(北京) |
| 30 | `assign-state` | 受让人州 | Assignee State | assign-state=("New York") |
| 31 | `assign-city` | 受让人城市 | Assignee City | assign-city=("New York") |
| 32 | `AEE-PROVINCE` | 受让人省市 | Aee Province | AEE-PROVINCE=北京 |
| 33 | `AEE-CITY` | 受让人地市 | Aee City | AEE-CITY=北京 |
| 34 | `AEE-COUNTY` | 受让人区县 | Aee County | AEE-COUNTY=曲阜 或 AEE-COUNTY=越秀 |
| 35 | `ASSIGNOR-ADD` | 转让人地址 | Assignor Address | ASSIGNOR-ADD=(北京) |
| 36 | `AOR-PROVINCE` | 转让人省市 | Aor Province | AOR-PROVINCE=北京 |
| 37 | `AOR-CITY` | 转让人地市 | Aor City | AOR-CITY=北京 |
| 38 | `AOR-COUNTY` | 转让人区县 | Aor County | AOR-COUNTY=曲阜 或 AOR-COUNTY=越秀 |
| 39 | `at-country` | 代理人国别 | Attorney Country | at-country=(CN) |
| 40 | `at-add` | 代理人地址 | Attorney Address | at-add=(Cupertino CA) |
| 41 | `at-city` | 代理人城市 | Attorney City | at-city=(New York) |
| 42 | `at-state` | 代理人所在州 | Attorney State | at-state=(HI) |
| 43 | `lgi-region` | 裁决判决发生地 | Legal Judgement region | lgi-region=(北京) |
| 44 | `where` | 地址 | All Address | where=(北京) |
| 45 | `DE-country` | EP指定生效国 | Valid of EP Designate State | de-country=AT |
| 1 | `an` | 申请号 | Application Number | an=(CN201010196166) |
| 2 | `ann` | 申请号号码 | Application Number without Country Code | ann=(201010196166) |
| 3 | `pn` | 公开(公告)号 | Publication Number | pn=(CN1942853A) |
| 4 | `pnn` | 公开(公告)号号码 | Document Number | pnn=(168742) |
| 5 | `PU-PN` | 首次公开号 | Initial Publication Number | PU-PN=CN1942853A |
| 6 | `GRANT-PN` | 授权公告号 | Grant Number | GRANT-PN=CN1942853B |
| 7 | `rpnd-DWPI` | DWPI相关公开号 | Related Publication Number - DWPI | rpnd-DWPI=(US7167615) |
| 8 | `pr` | 优先权号 | Priority Number | pr=(US10338820) |
| 9 | `pr-DWPI` | DWPI优先权号 | Priority Number-DWPI | pr-DWPI=(US10338820) |
| 10 | `prn` | 优先权号号码 | Priority Number without Country Code | prn=(10338820) |
| 11 | `pt` | 公开类型 | Publication Type | pt=(1) |
| 12 | `PAT` | 专利类型 | Patent Type | PAT=1 |
| 13 | `pnk` | 专利文献种类标识代码 | Publication Kind | pnk=(A) |
| 14 | `mf` | 简单同族 | Main Family | mf=(US20040131470A1) |
| 15 | `cf` | 扩展同族 | Complete Family | cf=(US20040131470A1) |
| 16 | `mfn` | 简单同族个数 | Main Family Number | mfn=(4) 或 mfn=[007 to 010] |
| 17 | `cfn` | 扩展同族个数 | Complete Family Number | cfn=(003) 或 cfn=[008 to 010] |
| 18 | `if` | DocDB同族 | DocDB Family | if=(JP2006223888A) |
| 19 | `ifn` | DocDB同族个数 | DocDB Family Number | ifn=(5) |
| 20 | `f-dwpi` | DWPI同族 | DWPI Patent Family | f-dwpi=CN207111638U |
| 21 | `fn-dwpi` | DWPI同族个数 | DWPI Family Number | fn-dwpi=5 或 fn-dwpi=[7 to 10] |
| 22 | `Fa-country` | 同族国家/地区 | Family Country/Area | fa-country=(CN and US and jp) |
| 23 | `Fa-country-DWPI` | DWPI同族国家/地区 | DWPI Family Country Number | Fa-country-DWPI=(CN and US and jp) |
| 24 | `FCN-DWPI` | DWPI同族国家个数 | DWPI Family Country Number | FCN-DWPI=60 或 FCN-DWPI=[40 to 50] |
| 25 | `number` | 号码 | All Number | number=201310624237 |
| 26 | `ri-num` | 复审无效决定号 | Reexamination/Invalidation Decision Number | ri-num=(FS33558) |
| 27 | `ri-inernal` | 复审无效委内编号 | Reexamination/Invalidation Internal Number | ri-inernal=(1F22751) |
| 28 | `license-no` | 许可合同备案号 | License Filing Number | license-no=(2012990000215) |
| 29 | `pledge-no` | 质押号 | Pledge Filing Number | pledge-no=(2007110000354) |
| 30 | `ian` | PCT国际申请申请号 | PCT Application Number | IAN=(19940622 PCTSE9400622 ) or IAN=(PCTSE9400622 ) |
| 31 | `ipn` | PCT国际申请公开号 | PCT Publication Number | IPN=(19950112 WO9501185) or IPN=(WO9501185) |
| 32 | `san` | 母案 | Parent Application | san=CN200580009877.6 |
| 33 | `subsan` | 分案 | Divisional Application | subsan=CN200910141118.5 |
| 34 | `esm` | 一案双申 | Dual Application | esm=(CN201510027482.4) |
| 35 | `Continuation-parent` | 延续母案 | Continuation parent | Continuation-parent= US15288130 |
| 36 | `continuation-inpart-parent` | 部分延续母案 | Continuation inpart parent | continuation-inpart-parent= US14107976 |
| 1 | `ad` | 申请日 | Application Date | ad=(20080808) |
| 2 | `radd-DWPI` | DWPI相关专利申请日期 | Related Application Date-DWPI | radd-DWPI=(20200908) |
| 3 | `adm` | 申请月 | Application Month | adm=(201301) |
| 4 | `ady` | 申请年 | Application Year | ady=2013 |
| 5 | `pd` | 公开（公告）日 | Publication Date | pd=(20110104) 或 pd=(2011*) 或 pd=[20110101 to 20130101] |
| 6 | `PU-DATE` | 首次公开日 | Initial Publication Date | PU-DATE=20130612；PU-DATE=[20130601 to 20130630] |
| 7 | `PU-Year` | 首次公开年 | Initial Publication Year | PU-Year=2013；PU-Year=[2013 to 2013] |
| 8 | `PU-Month` | 首次公开月 | Initial Publication Month | PU-Month=（201301） |
| 9 | `pdy` | 公开年 | Publication Year | pdy=2013 |
| 10 | `pdm` | 公开月 | Publication Month | pdm=（201301） |
| 11 | `pr-date` | 优先权日 | Priority Date | pr-date=(20100212) 或 pr-date=(2010*) 或 pr-date=[2010 to 2011] |
| 12 | `pr-date-DWPI` | DWPI优先权日 | Priority Data-DWPI | pr-date-DWPI=(20100212) |
| 13 | `pryear` | 优先权年 | Priority Year | pryear=2013 |
| 14 | `ori-prdate` | 最早优先权日 | Earliest Priority Date | ori-prdate=[20091123 to 20190603]或ori-prdate=20020228 |
| 15 | `ct-ad` | 引证申请日 | Citation Application Date | ct-ad=(20090105) 或 ct-ad=[2012 to 2013] |
| 16 | `ct-pd` | 引证公开日 | Citation Publication Date | ct-pd=(20090108) 或 ct-pd=[2012 to 2013] |
| 17 | `ctfw-ad` | 被引证申请日 | Citation-Forward Application Date | ctfw-ad=(20110101) 或 ctfw-ad=(2011*) 或 ctfw-ad=[2011 to 2013] |
| 18 | `ctfw-pd` | 被引证公开日 | Citation-Forward Publication Date | ctfw-pd=(20110101) 或 ctfw-pd=(2011*) 或 ctfw-pd=[2011 to 2013] |
| 19 | `ctyear` | 引证公开年 | Ciation-Forward Application Year | ctyear=2013 |
| 20 | `subex-date` | 实质审查生效日 | Substantive Examination Date | subex-date=(20060503)或者subex-date=[20060501 to 20060531] |
| 21 | `GRANT-DATE` | 授权公告日 | Grant Date | GRANT-DATE=20130612；GRANT-DATE=[20130601 to 20130630] |
| 22 | `GRANT-Year` | 授权公告年 | Grant Year | GRANT-Year =2013；GRANT-Year =[2013 to 2013] |
| 23 | `GRANT-Month` | 授权公告月 | Grant Month | GRANT-Month=（201301） |
| 24 | `EXDT` | 预估到期日 | Estimated Maturity Date | EXDT=20130612；EXDT=[20130601 to 20130630] |
| 25 | `EXDT-Year` | 预估到期年 | Estimated Maturity Year | EXDT-Year=2013；EXDT-Year=[2013 to 2013] |
| 26 | `EXDT-Month` | 预估到期月 | EXDT Month | EXDT-Month=（201301） |
| 27 | `expiry-date` | 失效日 | Expiry Date | expiry-date=(20140326)或者expiry-date=[20140301 to 20140331] |
| 28 | `expiry-year` | 失效年 | Expiry year | expiry-year=[2002 TO 2018] 或 expiry-year=2014 |
| 29 | `ecd` | PCT进入国家阶段日 | PCT Entering National Phase | ecd=(20121213) |
| 30 | `pledgeyear` | 质押年 | Pledge Year | pledgeyear=2013 |
| 31 | `assignyear` | 转让年 | Assignment Year | assignyear=2013 |
| 32 | `licenseyear` | 许可年 | License Year | licenseyear=2013 |
| 27 | `doc-dc` | 文档整体更新时间 | Document Update Time | doc-dc=[2012 to 2013] 或 doc-dc=(2010*) |
| 28 | `ref-dc` | 引证整体更新时间 | Ciation Update Time | ref-dc=[2012 to 2013] 或 ref-dc=(2010*) |
| 29 | `cp-dc` | 专利引证更新时间 | Patent Ciation Update Time | cp-dc=[2012 to 2013] 或 cp-dc=(2010*) |
| 30 | `cn-dc` | 非专利引证更新时间 | Non-patent Ciation Update Time | cn-dc=[2012 to 2013] 或 cn-dc=(2010*) |
| 31 | `fc-dc` | 专利被引证更新时间 | Ciation-Forward Update Time | fc-dc=[2012 to 2013] 或 fc-dc=(2010*) |
| 32 | `fam-dc` | 同族信息更新时间 | Patent Family Update Time | fam-dc=[2012 to 2013] 或 fam-dc=(2010*) |
| 33 | `customs-dc` | 海关备案最近更新时间 | Custom Record Update Time | customs-dc=[2012 to 2013] 或 customs-dc=(2010*) |
| 34 | `change-dc` | 变更入库时间 | Bibilographic Data Update Time | change-dc=[2018 to 2019] 或 change-dc=(2019*) |
| 33 | `assign-date` | 转让执行日 | Assignment Execution Date | assign-date=(2005*) 或 assign-date=[2002 to 2012] |
| 34 | `assign-rd` | 转让登记日 | Assignment Record Date | assign-rd=(2005*) 或 assign-rd=[2002 to 2012] |
| 35 | `ri-date` | 复审无效决定日 | Reexamination-invalidation Decision Date | ri-date=(20110627) 或 ri-date=[2011 to 2012] |
| 36 | `lgi-date` | 法律文书日期 | Legal Instrument Date | lgi-date=[2010 to 2013] 或 lgi-date=(2011*) |
| 37 | `lgi-fd` | 立案日期 | Filing Date | lgi-fd=[20080625 to 20120624] 或 lgi-fd=(20120104) |
| 38 | `lgi-cd` | 结案日期 | Close Date | lgi-cd=[20080625 to 20120624] 或 lgi-cd=(20120104) |
| 39 | `lgd` | 法律状态公告时间 | Legal Event Publication Date | lgd=(20120104) |
| 40 | `pledge-date` | 质押生效日 | Pledge Effective Date | pledge-date=(20120629)或pledge-date=(201206*)或pledge-date=(2012*) |
| 41 | `license-date` | 许可合同备案日期 | License Filing Date | license-date=(20120426)或license-date=(201204*）或license-date=(2012*) |
| 42 | `license-sd` | 许可合同履行起始日 | License Contract Enforcement Date | license-sd= (20090520)或者license-sd=[20130101 to 20140101] |
| 43 | `license-td` | 许可合同履行终止日 | License Contract End Date | license-td=(20130828)或者license-td=[20130801 to 20130831] |
| 44 | `pledge-cd` | 质押变更日 | Pledge Change Date | pledge-cd=(20130620)或者pledge-cd=[20130601 to 20130630] |
| 45 | `pledge-rd` | 质押解除日 | Pledge Release Date | pledge-rd=(20130809)或者pledge-rd=[20130801 to 20130831] |
| 46 | `lgiyear` | 诉讼年 | Ligitation Year | lgiyear=(2013) |
| 47 | `lgi-fy` | 立案年 | Filing Year | lgi-fy=(2013) |
| 48 | `lgi-cy` | 结案年 | Close Year | lgi-cy=(2013) |
| 49 | `patent-life` | 专利寿命 | Patent Life | patent-life=(10) |
| 50 | `ex-time` | 审查时长 | Examination Duration | ex-time=(005)或者ex-time=[005 to 010] |
| 51 | `pfex-time` | 进入实质审查时长 | Duration of substantive examination | pfex-time=(005)或者pfex-time=[005 to 010] |
| 52 | `re-date` | 复审决定日 | Reexamination Decision Date | re-date=2010 |
| 53 | `in-date` | 无效决定日 | Invalidation Decision Date | in-date=201811 |
| 54 | `or-date` | 口审日期 | Oral Hearing Date | or-date=[20170109 to 20170526] |
| 55 | `reapp-date` | 复审请求日 | Reexamination Request Date | reapp-date=20160304 |
| 56 | `inapp-date` | 无效请求日 | Invalidation Request Date | inapp-date=201710 |
| 57 | `ori-pryear` | 最早优先权年 | Earliest priority year | ori-pryear=2016 |
| 58 | `ori-pryear-DWPI` | DWPI优先权年-最早 | Priority Year-Earliest-DWPI | ori-pryear-DWPI=2021 |
| 1 | `status` | 专利有效性 | Patent Status | status=(审中 or 有效) |
| 2 | `status-lite` | 当前法律状态 | Current Legal Status | status-lite=(公开) |
| 3 | `lg` | 法律状态文字信息 | Legal Status in Text | lg=(联想) |
| 4 | `lge` | 法律状态中的法律事件 | Legal Event | lge=(实质审查) |
| 5 | `lgf` | 法律状态效果 | Legal Event Effect | lgf=(Positive) 或 lgf=(Negative) |
| 6 | `lgc` | 法律状态代码 | Legal Event Code | lgc=(FPAY) |
| 7 | `ri-type` | 复审无效类型 | Reexamination/Invalidation Type | ri-type=(无效审查决定) 或 ri-type=(复审决定) |
| 8 | `ri-text` | 复审无效全文 | Reexamination/Invalidation Fulltext | ri-text=(豆浆机) |
| 9 | `ri-ap` | 复审/无效请求人 | Reexamination/Invalidation Applicant | ri-ap=(陆国强) |
| 10 | `inapp-date` | 复审无效请求日 | Filing Date of Reexamination/Invalidation | inapp-date=20110909 |
| 11 | `re-decision` | 复审无效决定 | Reexamination/Invalidation Decision | re-decision=（维持原驳回决定） |
| 12 | `ri-basis` | 复审无效法律依据 | Reexamination/Invalidation Legal Basis | ri-basis=(专利法第22条) |
| 13 | `ri-point` | 复审无效决定要点 | Reexamination/Invalidation Decision-Key Point | ri-point=(新颖性) |
| 14 | `lgi-court` | 法庭 | Legal Court | lgi-court=(山东省高级人民法院) |
| 15 | `lgi-judge` | 法官 | Judge | lgi-judge=("Honorable Richard A. Posner") |
| 16 | `lgi-firm` | 诉讼律师事务所 | Lawfirm | lgi-firm="Brooks Kushman" |
| 17 | `lawyer` | 律师 | lawyer | lawyer="Karen Jacobs" |
| 18 | `lgi-cause` | 案由 | Cause of Action | lgi-cause= |
| 19 | `lgi-no` | 诉讼案件号 | Case Number | lgi-no=215cv01227 |
| 19 | `assign-text` | 专利转移原因 | Assignment Reason in Text | assign-text=( "ASSIGNMENT OF ASSIGNORS INTEREST") |
| 20 | `lgi-ti` | 法律文书题目 | Legal Instrument Title | lgi-ti=(专利权权属) |
| 21 | `lgi-text` | 法律文书具体内容 | Legal Instrument Fulltext | lgi-text=(豆浆机) |
| 22 | `lgi-type` | 法律文书种类 | Legal Instrument Tpye | lgi-type=(民事判决书) |
| 23 | `lgi-no` | 法律文书编号 | Legal Instrument Number | lgi-no=(第66号) |
| 24 | `lgi-procedure` | 审理程序 | Trial Procedure | lgi-procedure=一审 |
| 25 | `lgi-plaintiff` | 原告 | Plaintiff | lgi-plaintiff=(Foundation) |
| 26 | `lgi-defendant` | 被告 | Defendant | lgi-defendant=(Oxford) |
| 27 | `license-type` | 许可类型 | License Type | license-type=独占许可 |
| 28 | `license-stage` | 许可备案阶段 | License Stage | license-stage=生效 |
| 29 | `license-cs` | 当前许可备案阶段 | Current License Stage | license-cs=变更 |
| 30 | `lee-current` | 当前被许可人 | Current Licensee | lee-current=(上海裕隆) |
| 31 | `pee-current` | 当前质权人 | Current Pledgee | pee-current=(成都生产力促进中心) |
| 32 | `pledge-type` | 质押保全类型 | Security Pledge Type | pledge-type=(保全) |
| 33 | `pledge-stage` | 质押/保全合同备案阶段 | Security Pledge Stage | pledge-stage=(生效 OR 变更 OR 注销) |
| 34 | `lawtxt` | 法律状态全文 | Legal Stutus Fulltext | lawtxt=("实质审查的生效IPC(主分类)") |
| 35 | `assign-flag` | 转让标签 | Assignment Flag | assign-flag= 1 |
| 36 | `Assign-times` | 转让次数 | Assignment Times | assign-times=3 |
| 37 | `assign-no` | 转让登记号 | Assignment Number | assign-no=054928/0179 |
| 38 | `assign-type` | 转让类型 | Assignment Type | assign-type=（I） |
| 39 | `licence-flag` | 许可标签 | License Flag | licence-flag=1 |
| 40 | `Licence-times` | 许可次数 | Licencing Times | licence-times=3 |
| 41 | `plege-flag` | 质押/保全标签 | Security Pledge Flag | plege-flag=1 |
| 42 | `pledge-times` | 质押/保全次数 | Security Pledge Times | pledge-times=3 或 pledge-times=[7 to 10] |
| 43 | `ree-flag` | 复审无效审查决定标签 | Reexamination-Invalidation Decision Flag | ree-flag=1 |
| 44 | `lgi-flag` | 诉讼标签 | Litigation Flag | lgi-flag=1 |
| 45 | `Lgi-times` | 诉讼次数 | Lgi-times | Lgi-times=3 |
| 46 | `action-types` | 诉讼类型 | Litigation Type | action-types=侵权案件 |
| 47 | `customs-Flag` | 海关专利标签 | Customs Record Flag | customs-flag=1 |
| 48 | `all-flag` | all标签 | All Flag | all-flag=转让 |
| 49 | `Tovalide-date` | 法律状态由未授权或失效变为有效 | Status changed from unauthorized or invalid into valid | tovalide-date=20160427 |
| 50 | `FLAG-337` | 337标记 | FLAG-337 | FLAG-337=1 |
| 1 | `ct` | 引证信息（backward） | Citation | ct=(US6212494B1) |
| 2 | `ctfw` | 被引证信息（forward） | Citation-Forward | ctfw=(US7848362B2) |
| 3 | `ct-self` | 自引信息 | Self-citing | ct-self=CN201797047U |
| 4 | `ct-oth` | 他引信息 | Non-self-citing | ct-oth= US7190310B2 |
| 5 | `ctfw-self` | 被自引信息 | Self-cited | ctfw-self= CN105433791B |
| 6 | `ctfw-oth` | 被他引信息 | Non-self-cited | ctfw-oth= CN105167656B |
| 7 | `ct-times` | 引证次数（backward） | Citation Times | ct-times=(10) 或 ct-times=[7 to 10] |
| 8 | `ctfw-times` | 被引证次数 （forward） | Citation-Forward Times | ctfw-times=(7) 或 ctfw-times=[7 to 10] |
| 9 | `ct-self-times` | 自引次数 | Self-citing Times | ct-self-times=7 或 ct-self-times=[3 to 5] |
| 10 | `ct-oth-times` | 他引次数 | Non-self-citing Times | ct-oth-times=7 或 ct-oth-times=[3 to 5] |
| 11 | `ctfw-self-times` | 被自引次数 | Self-cited Times | ctfw-self-times=7 或 ctfw-self-times=[3 to 5] |
| 12 | `ctfw-oth-times` | 被他引次数 | Non-self-cited Times | ctfw-oth-times=7 或 ctfw-oth-times=[3 to 5] |
| 13 | `fct` | 家族引证（backward） | Family Citation | fct=(US6212494B1) |
| 14 | `fctfw` | 家族被引证（forward） | Family Citation-Forward | fctfw=(CN101547122B) |
| 15 | `ct-ap` | 引证申请人（backward） | Citation Applicant | ct-ap=(apple) |
| 16 | `ctfw-ap` | 被引证申请人（forward） | Citation-Forward Applicant | ctfw-ap=(apple) |
| 17 | `fct-ap` | 家族引证申请人(backward) | Family Citation Applicant | fct-ap=(apple) |
| 18 | `fctfw-ap` | 家族被引证申请人（forward） | Family Citation-Forward Applicant | fctfw-ap=(apple) |
| 19 | `ct-no` | 引证号码(backward) | Citation Number | ct-no=(6386370) |
| 20 | `ctfw-no` | 被引证号码（forward） | Citation-Forward Number | ctfw-no=(7848362) |
| 21 | `ct-auth` | 引证国别(backward) | Citation Authority | ct-auth=(US) |
| 22 | `ctfw-auth` | 被引证国别（forward） | Citation-Forward Authority | ctfw-auth=(US) |
| 23 | `ct-code` | 引证类别(backward) | Origin Code for Citation | ct-code=(A) 或 ct-code=(X) 或 ct-code=(Y) |
| 24 | `ct-X` | X引证文献 | Citation File-X | CT-X=CN201590919U |
| 25 | `fct-times` | 家族引证次数(backward) | Family Citation Times | fct-times=(5) |
| 26 | `fctfw-times` | 家族被引证次数（forward） | Family Citation-Forward Times | fctfw-times=(20) |
| 27 | `ctnp` | 非专利引证 | Non-patent Citation | ctnp=(nature) |
| 28 | `ct-source` | 引证来源 | Citing Source | ct-source=A |
| 29 | `ctfw-source` | 被引证来源 | Cited Source | ctfw-source=A |
| 2 | `ap-group` | 申请人(多语种） | Applicant (Multilingual) | ap-group=(清华大学) |
| 3 | `ap-grouptt` | 申请人(多语种）(精确匹配) | Applicant (Multilingual) (Exact Match) | ap-grouptt=(清华大学) |
| 5 | `aptt` | 申请人（精确匹配） | Applicant(Exact Match) | aptt=(清华大学) |
| 14 | `aeett` | 受让人(精确匹配) | Assignee(Exact Match) | aeett=华为 |
| 19 | `intt` | 发明（设计）人（精确匹配） | Inventor/Designer(Exact Match) | intt=(刘洋) |
| 50 | `patenteett` | 当前权利人(精确匹配) | Patentee(Exact Match) | patenteett=华为 |
| 58 | `bclass` | 国民经济行业分类 | National Industries Classification | bclass=(C3525) |
| 59 | `mbclas1` | 主国民经济行业门类 | Main industry category | mbclas1=(C) |
| 60 | `mbclas2` | 主国民经济行业大类 | Main industry-class | mbclas2=(C39) |
| 61 | `mbclas3` | 主国民经济行业中类 | Main industry-middle class | mbclas3=(C352) |
| 62 | `mbclas4` | 主国民经济行业小类 | Main industry-sub class | mbclas4=(C3521) |
| 63 | `mbclass` | 国民经济行业(主) | National Economic Industries (Main) | mbclass=(C3525) |
| 78 | `mindustry1` | 主新兴产业门类 | Main emerging industry category | mindustry1=(1) |
| 79 | `mindustry2` | 主新兴产业大类 | Major emerging industry class | mindustry2=(1.1) |
| 82 | `Industry-type` | 行业分类 | Industry classification | Industry-type=(eme) |
| 83 | `Mkclas1` | 知识密集大类 | Knowledge-intensive class | Mkclas1=(1) |
| 84 | `Mkclas2` | 知识密集中类 | Knowledge-intensive middle class | Mkclas2=(101) |
| 85 | `sc-main` | WOS学科分类号-一级学科 | First-level discipline | sc-main=A |
| 86 | `sc-section` | WOS学科分类号-学科方向 | Discipline direction | sc-section=A01 |
| 87 | `sc-class` | WOS学科分类号-WOS学科 | WOS-discipline | sc-class=A0101 |
| 88 | `sc-subclass` | WOS学科分类号-学科分类 | Subject classification | sc-subclass=A010101 |
| 89 | `Lngclas1` | 清洁能源产业大类 | Clean energy industry class | Lngclas1=(1) |
| 90 | `Lngclas2` | 清洁能源产业中类 | Clean energy industry middle class | Lngclas2=(1.1) |
| 91 | `Lngclas3` | 清洁能源产业小类 | Clean energy industry sub class | Lngclas3=(1.1.1) |
| 92 | `Cpclas1` | 清洁生产产业大类 | Cleaner production industry class | Cpclas1=(1) |
| 93 | `Cpclas2` | 清洁生产产业中类 | Cleaner production industry middle class | Cpclas2=(1.1) |
| 94 | `Cpclas3` | 清洁生产产业小类 | Cleaner production industry sub class | Cpclas3=(1.1.0) |
| 95 | `digclas1` | 数字经济核心产业大类 | Digital economy core industry class | digclas1=(01) |
| 96 | `digclas2` | 数字经济核心产业中类 | Digital economy core industry middle class | digclas2=(0101) |
| 97 | `digclas3` | 数字经济核心产业小类 | Digital economy core industry sub class | digclas3=(010101) |
| 43 | `use-cn` | 用途-中文 | USE (Chinese) | use-cn=机器人 |
| 44 | `use-en` | 用途-英文 | USE (English) | use-en=robot |
