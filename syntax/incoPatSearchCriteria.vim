" Vim syntax file
" Language:	Search Criteria
" Maintainer:	Lin Kun <ssfjhh at gmail.com>
" Last Change:	2026 Oct 17

if exists("b:current_syntax")
    finish
endif

syntax clear
syntax case     ignore       " 忽略大小写

set cindent shiftwidth=8     " 自动缩进4空格
set tabstop=8                " 设置tab键的宽度

syntax match Keyword '\c\<\%(and\|or\|not\|to\|opt\)\>'
syntax match scOperator "\(>=\|<=\|>\|<\|=\)"

" 邻近算符：(w)/(n)/(s)/(p)/(sen)，以及带词距的 (0w)~(99w)、(0n)~(99n)
syntax match scConnector "\c(\%(\d\{1,2}[wn]\|[wnsp]\|sen\))"
" 字段名：官方词法只要求「标识符 =」，不依赖白名单；未知字段标红提示
syntax match scUnknownKey '\c\<[a-z][a-z0-9_-]*\ze\s*\%(=\|[<>]=\?\)'
" 已知字段白名单（优先级高于上面的通用匹配，故已知字段仍按 scKEY 高亮）
" 共 474 个：按官方《原始字段代码说明》(help/sysdoc/helpcode.html) 的字段顺序排列，
" 外加 R / RAD / RPD 三个语义检索关键词（见官方《超级排序》帮助页，不在字段代码表内）。
syntax match scKEY '\c\(r\|rad\|rpd\|ti\|ab\|tiab-dwpi\|claim\|ipc\|loc\|an\|rand-dwpi\|ad\|pn\|pd\|ap-lite\|ap\|ap-group\|ap-grouptt\|ap-all\|aee\|ap-add\|ap-country\|in\|in-dwpi\|lor\|lee\|lg\|ri-text\|status\|lgi-party\|ti-cn\|ti-otlang\|ti-en\|ti-dwpi\|ab-cn\|ab-otlang\|ab-en\|use-dwpi\|adv-dwpi\|novelty-dwpi\|abstract-dwpi\|dtd-dwpi\|activity-dwpi\|mec-dwpi\|foc-dwpi\|draw-dwpi\|tiab\|first-claim\|first-claim-cn\|first-claim-en\|first-claim-ot\|indepclaims-cn\|depclaims-cn\|no-indepclaims\|no-depclaims\|len-first-claim\|claim-en\|claim-cn\|claim-ot\|no-claim\|tiabc\|des\|des-ot\|des-en\|des-cn\|technical-field\|background-art\|disclosure\|mode-for-invention\|no-image\|effect-s-cn\|effect-ph-cn\|effect-cn\|effect-cn-3\|effect-cn-2\|effect-cn-1\|effect-triz\|all\|full\|filing-lang\|prd-flag\|prd\|prd-dwpi\|page\|vlstar\|vlstar-1\|vlstar-2\|vlstar-3\|reward-level\|reward-name\|reward-session\|std-type\|std-project\|std-num\|std-company\|std-flag\|cas-no\|drug-name-cn\|drug-name-en\|company\|brand-name\|active-ingredient\|target\|indication\|patent-expiration\|ped-patent-expiration\|ap-or\|ap-ot\|ap-ts\|aptt\|apnor\|apnortt\|ap-root\|ap-first\|ap-new-name\|ap-otadd\|no-ap\|who\|patentee\|patenteett\|patenteenor\|patenteenortt\|assign-party\|aor\|aor-type\|aeett\|aeenor\|aeenortt\|aee-type\|intt\|in-or\|in-ot\|in-ts\|in-first\|no-in\|in-new-name\|in-current\|lor-type\|lee-type\|opponent\|at\|agc\|re-ap\|in-ap\|ri-me\|ri-ae\|ri-leader\|por\|pee\|ex\|ap-type\|patentee-type\|co-dwpi\|ck-dwpi\|ck-type-dwpi\|ap-as\|ap-en\|ap-reg-location\|ap-company-org-type\|ap-estiblish-time\|ap-usc\|ap-reg-number\|ap-reg-status\|ap-list-code\|ipc-main\|ipc-section\|ipc-class\|ipc-subclass\|ipc-group\|ipcm-section\|ipcm-class\|ipcm-subclass\|ipcm-group\|ipc-subgroup\|ipc-low\|ipc-high\|ipcm-low\|ipcm-high\|ipc-dwpi\|ipc-section-dwpi\|ipc-class-dwpi\|ipc-subclass-dwpi\|ipc-group-dwpi\|ipc-subgroup-dwpi\|ipc-f-dwpi\|ipc-section-f-dwpi\|ipc-class-f-dwpi\|ipc-subclass-f-dwpi\|ipc-group-f-dwpi\|ipc-subgroup-f-dwpi\|dc-dwpi\|dc-section-dwpi\|dc-class-dwpi\|mc-dwpi\|mc-section-dwpi\|mc-class-dwpi\|mc-group-dwpi\|mc-subgroup-dwpi\|mc-subgroupd-dwpi\|mc-fullmc-dwpi\|mc-fullmcx-dwpi\|loc-class\|loc-subclass\|ecla\|ecla-section\|ecla-class\|ecla-subclass\|ecla-group\|ecla-subgroup\|uc\|uc-main\|cpc\|cpc-section\|cpc-class\|cpc-subclass\|cpc-group\|cpc-subgroup\|fi\|ft\|class\|phc\|bclas1\|bclas2\|bclas3\|bclas4\|cpc-main\|cpcm-section\|cpcm-class\|cpcm-subclass\|cpcm-group\|cpcm-subgroup\|industry1\|industry2\|in-country\|auth\|pnc\|ap-oradd\|ap-tsadd\|pr-au\|pr-au-dwpi\|oriprc-dwpi\|ap-province\|pc-cn\|ap-pc\|city\|county\|patentee-add\|patentee-province\|patentee-city\|patentee-county\|in-add\|in-oradd\|in-tsadd\|in-otadd\|in-city\|in-state\|assign-country\|assignee-add\|assignee-cadd\|assign-state\|assign-city\|aee-province\|aee-city\|aee-county\|assignor-add\|aor-province\|aor-city\|aor-county\|at-country\|at-add\|at-city\|at-state\|lgi-region\|where\|de-country\|ann\|pnn\|pu-pn\|grant-pn\|rpnd-dwpi\|pr\|pr-dwpi\|prn\|pt\|pat\|pnk\|mf\|cf\|mfn\|cfn\|if\|ifn\|f-dwpi\|fn-dwpi\|fa-country\|fa-country-dwpi\|fcn-dwpi\|number\|ri-num\|ri-inernal\|license-no\|pledge-no\|ian\|ipn\|san\|subsan\|esm\|continuation-parent\|continuation-inpart-parent\|radd-dwpi\|adm\|ady\|pu-date\|pu-year\|pu-month\|pdy\|pdm\|pr-date\|pr-date-dwpi\|pryear\|ori-prdate\|ct-ad\|ct-pd\|ctfw-ad\|ctfw-pd\|ctyear\|subex-date\|grant-date\|grant-year\|grant-month\|exdt\|exdt-year\|exdt-month\|expiry-date\|expiry-year\|ecd\|pledgeyear\|assignyear\|licenseyear\|doc-dc\|ref-dc\|cp-dc\|cn-dc\|fc-dc\|fam-dc\|customs-dc\|change-dc\|assign-date\|assign-rd\|ri-date\|lgi-date\|lgi-fd\|lgi-cd\|lgd\|pledge-date\|license-date\|license-sd\|license-td\|pledge-cd\|pledge-rd\|lgiyear\|lgi-fy\|lgi-cy\|patent-life\|ex-time\|pfex-time\|re-date\|in-date\|or-date\|reapp-date\|inapp-date\|ori-pryear\|ori-pryear-dwpi\|status-lite\|lge\|lgf\|lgc\|ri-type\|ri-ap\|re-decision\|ri-basis\|ri-point\|lgi-court\|lgi-judge\|lgi-firm\|lawyer\|lgi-cause\|lgi-no\|assign-text\|lgi-ti\|lgi-text\|lgi-type\|lgi-procedure\|lgi-plaintiff\|lgi-defendant\|license-type\|license-stage\|license-cs\|lee-current\|pee-current\|pledge-type\|pledge-stage\|lawtxt\|assign-flag\|assign-times\|assign-no\|assign-type\|licence-flag\|licence-times\|plege-flag\|pledge-times\|ree-flag\|lgi-flag\|lgi-times\|action-types\|customs-flag\|all-flag\|tovalide-date\|flag-337\|ct\|ctfw\|ct-self\|ct-oth\|ctfw-self\|ctfw-oth\|ct-times\|ctfw-times\|ct-self-times\|ct-oth-times\|ctfw-self-times\|ctfw-oth-times\|fct\|fctfw\|ct-ap\|ctfw-ap\|fct-ap\|fctfw-ap\|ct-no\|ctfw-no\|ct-auth\|ctfw-auth\|ct-code\|ct-x\|fct-times\|fctfw-times\|ctnp\|ct-source\|ctfw-source\|bclass\|mbclas1\|mbclas2\|mbclas3\|mbclas4\|mbclass\|mindustry1\|mindustry2\|industry-type\|mkclas1\|mkclas2\|sc-main\|sc-section\|sc-class\|sc-subclass\|lngclas1\|lngclas2\|lngclas3\|cpclas1\|cpclas2\|cpclas3\|digclas1\|digclas2\|digclas3\|use-cn\|use-en\)\ze\s*\%(=\|[<>]=\?\)'
syntax match scPC '\<\([A-HY]\d\{2}[A-Z]\d\{1,4}/\d\{1,6}\(\([A-Z]\d[A-Z]\d\?\|[A-Z]\d\?\)\|\.\(\d*[A-Z]\|\d\+\)\)\?\|[A-HY]\d\{2}[A-Z]\d\{1,4}/\d{1,6}\?\|[A-HY]\d\{2}[A-Z]\d\{1,4}/\?\|[A-HY]\d\{2}[A-Z]\?\|[A-HY]-\@!\)\>'
syntax match scUC '\<\d\+/\d\+\(\.\d\+\)\?\|\d\+/\|\d\+\>'
" 日本 F-term 分类号：主题码 = 1 位数字 + 1 位字母 + 3 位数字，
" 可接术语码 = 2 位字母 + 2 位数字（与主题码之间可带官方示例里的 /）；
" 只有主题码也算合法。例：3L093BB25、2D061/BA01、3C001。
" 整段按 scFT 高亮，尾部数字不再被 scUC 当成普通数字。
syntax match scFT '\c\<[0-9][a-z]\d\{3}\%(\/\?[a-z]\{2}\d\{2}\)\?\>'
syntax match scComment /#.*/
syntax region scString matchgroup=scQuote start=/"/ end=/"/
" 频率算符：(nf)，n 为 1~100 的整数，故 (0f)/(101f)/(f) 都不是频率算符
syntax match scFrequency "\c(\%(100\|[1-9]\d\?\)f)"
syntax match scTreeAt "\cTREE@"
syntax match scDelimiter '[\[\]|$*?]'
syntax region scString matchgroup=scQuote start=/'/ end=/'/
" syntax region scString matchgroup=scQuote start=/\v"/ skip=/\v\\./ end=/\v"/ " 因为检索式不支持转义的特殊字符，因此skip参数是不需要的

highlight link scOperator  Operator
highlight link scConnector Delimiter
highlight link scPC        Number
highlight link scUC        Number
highlight link scFT        Function
highlight link scKEY       Identifier
highlight link scUnknownKey Error
highlight link scComment   Comment
highlight link scString    String

highlight link scFrequency Special
highlight link scTreeAt    Operator
highlight link scDelimiter Delimiter
highlight scQuote ctermfg=green guifg=green

let b:current_syntax = "incoPatSearchCriteria"
