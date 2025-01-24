#!/usr/bin/env bash
#shellcheck enable=require-variable-braces
#shellcheck disable=SC2034

### Definition: variables API_URL, BACKUPS, NAMES, PAYLOAD, and WILDCARDS
### IMPORTANT : Order of MODRINTH arrays must be parallel
### Alphabetical by MODRINTH_NAMES
### DO NOT EDIT ABOVE THIS LINE

# ADVANCED:
# The API URL, which must understand Modrinth API, to which all requests will be sent
# Note: https://curserinth-api.kuylar.dev/ may work for accessing Curseforge through the Modrinth API, but this is untested and unsupported by download.sh and the developer of Curserinth, who has archived their project.
# Don't change if you don't know what you're doing
MODRINTH_API_URL='https://api.modrinth.com/v2'

# The sha512 hash of any jar from the Modrinth project you want. This is only used when downloading a Modrinth project for the first time, or if the download was deleted.
MODRINTH_BACKUPS=(
  '3f9eb5857c7a0a078abc11e53627669ccc9eb23177c64b1e5741c6cf2268bd50c9f979a92d746bcd394f7a961c8b9ba346a3ea4452e87ed3583053d2bfcae5cd'
  '400863077f08aa5f511e0985804fa0425ccfa7163bde0614ce0e8fb463ee230d509bc10c7350375ac27553fc1416430cc2b148cf7dd295eadfc980645a8932d2'
  'bc35cc37a221fbc6f7fca293e72aad0877d8c9d07067ff0b4c8f51dcddbb82ac7cbbb86d1550eef7690bcd1ecf09625f0389f39ae9a252eec5d8511ba7deec4a'
  'b6b042dde4d58d858dc7dbad95c40020ad1f9e54e6c078f4534b1df1253f3f339e32d55d83f3796030b0f11a495cfcf872ef5c48750591121ce4bb32147709f4'
  '2a82b76b75d58482b6e21d5c18b74a9856bb2be2bb6a6224b8a28fe0306258e96abbfc0e7b48b60be0b5b2e5aa573f887559f7f02f8367a7328d568017c4b8aa'
  '5faae5cb3d8759837ec341c605dd9c8b6b32a908e7e1f1248b3b2567c5f9969079df33694cdfb6c743a732bfc9d5824843a93edec07f09e68f8b408e355d15e7'
  '0ef96b8409904c0ce1b9a875260f252615d7b46704082cfd10ffee88d2d506984ad0c31a91e5cb3392f454bc646b7676c392ac94d78474f156aa519f9501f3d0'
  '78bdb5a8d40410cfdd32e630c63d00e1872f423c1e07e90601e6391dba3ea493addd73a0c5b447de1bf9075aa678ee2959dc59b0267f1c10378e87d7e4e79c35'
  '03589a8d05c17dbb4271c212d0eb00c53d9d5c0705f63c7816ff9e099245db71f94e7c544e323beaeac28d30bd3807eeccb1352792cb6d778ff6ecf68f4635c7'
  '9dede017b69fbf0060e9cf4c0ac0d179ac09e1937be822b674eacc7e121b6660d82a3bca78ed6f1861d6eb380b16ea02e5b46d970c0a0bf9a9f8fac3b6afb87a'
  'b4ea87f710dbe1703f68611cfbbc3dac11d50b78af90b5ee52f32d29018f47f6ea7bf8d9de330cff1437db8c9ca004f94d436f711aa90279f8fce316fba21523'
  '3d9ec324a1cbe4d98bb4b47bea721e1b629e11ba9b2c07d6da7a844b941f2ce71092edfbe56c62c8e14c7eda15652986de464b80ececb22334181510f374ccbb'
  'af2d0825ec4e3521fd82b0a5fd5a3f04daf98e09b138d099407861c03a4e17546900befd791a7abe7cbe109c3045dee0646d02f1703b8e68bc37903d21c20acd'
  '024e9aa775037fe8727ac8aca55f68d2f6782dd87d099446f967ebbeb6eab73f0f0580eca100cb565f70bab02abce03239af0fca17248ceef2c05caa1cfcdd1e'
  '9b7dc686bfa7937815d88c7bbc6908857cd6646b05e7a96ddbdcada328a385bd4ba056532cd1d7df9d2d7f4265fd48bd49ff683f217f6d4e817177b87f6bc457'
  'aca5e11958e07e6da38fdbe044a9a5d0f2e976c8bd390dcfec91ba6f92b1ef2d801f98bb744f76d589e3f464dbc61d4181037453ee3d9b655df1fd15d240cf22'
  '6aaf011fd04da2f2839da8e037add942588676385906d8ddad2927ca88414a37463f1b2e2ee2209a87cda8d2af9448a29e55e86ba2d94e857e46d28545ea7bbd'
  '15cf5c89b538191ec975cc4b0d7bcf4bfd07dbb089ab735a21e2bfb30c2080051df2c9af609f842a75a4a81d4e3b4dd061b2fe768e2e9982ee8732ab1c91cbee'
  'dc9bc65146f41cf99c46b46216dd3645be7c45cfeb2bc7cdceaa11bcd57771cdf2c30e84ce057f12b8dbf0d54fb808143cf46d92626370011ba5112bec18e720'
  '81716845073bb3bd5bff59ba9ca34605b2367d905569646bba4a338402eb192c2520418e098a3ef9545ceef9f80779ad9b9ee64b28f1bb629b8a875465dcd6d3'
  'b417d09e259f7607433bd83fd2d9650f17cece06be0ddea437b2e65defc40e1aec0cb08838eb01ec4e109158a40b857064411520cc03126e1a7300abcd8a6c59'
  '3b715a799cf38adbcba9d6b08de2bf50965e5974fac3bc092920c829550f7042f5882d9037d9c321ba1e3cade00b285171c0f85772e2409f0e7851e86aa0ecbd'
  'db7502fadd4ddb3122c5bce506ac408b5f5141017bed645870dded4c00841d76614cabff965359de475baedbd9df550128ce559a6d0fce94454ca4e809523247'
  'e1475f88623f53ef7609349af32acffcdcca80274d008096dd90369532a5198a6653a62d54bf97001edbb423ac172dbcf7f5298ad2c0e574f0973c21ad03f467'
  'f0abcdac514bd2b4eb6af3529eeb9980a6fef534d31244879acb291a9943151aeb34f372bf98ae01f6191870bf95e1c0bc36d522433353a1090b96e7ac03c417'
  '6713336913946be481a3a4d2f48aae54021c9259b0a0df3eb8c90d7fc55e72f7ebe6b4f49165c266c0d81d02343e2a216881d5194cf8d695d139e6d0b854a03d'
  'c4a31935ee7e4f4fcf97bfcb50b8ee49980f2c628faee4dac4841318f8a5f427cfc39b89092c5d21360f35d19915fac45c3b4b0bc2c8b0387d3403d8306be5c3'
  '21c93d576808582b23de61c63d6a5d3a8d8894ed59025272d8c75548f556bde87975698834cfb76357bb11bd4cbe81e5e1ea22c3905d93d9eb335089c119b0e8'
  'd7bb384b961088ae6fe1e0baef9895cd495a515d8337664bb534c36ae17e48188fc1c50cd9a06e3e53898870ada73e737f63853adf43e744fee11a64bad1059a'
  '53a6ca7dd4c83963d56b7dc5fbeb9b71090461049931a45b912fda5e09b8aa716d9504f2e97c023995062482df27946d81bbf771252baaca0d6f46333c3947bf'
  'd3fcf5440c9359ee84cdec6ab198a6b2e10e5b1939995d2b12837ffdaa1f82d3caa80b14107cf02380718c65f20672b1faca3a498d2b41d79c79de34b2f7189b'
  '603be4f5766681844f300eeb5540cd31c33d9e6411155c44ef1d46ec61a38d640285082132cb1c19820d002eeefddc111cec8c044685a44acb68efd3a1f30702'
  'ce6e8f7071bb37369ad3e90d844926b424e82d0fe0ffd0db7058abddc9cfcdd594e145c9395677ad70ec532f3da0b23b6862d1f1c20f7600263c215abb4fcea7'
  '166b3b52ed5639a823432ca9ff8806f0c5bc068bb25569ab1aff1b06409b0162f1dd5d7c060c6c7fa72c0aa757aa99348911fc9e1b18a3668ce5d08cdb7598fe'
  '9ce4ae5f64661b2ab52e2a62636bc0fcd023bb304e84b8e1dbef9461a1c6ea1fee187d8afc54618743c9e6155fb64e926a326e3fcf33a566f31c82214810e69e'
  'b5a9fc2775bc8c020cb88b898dcdf473bf77f03ef41be1661a117872b16582a7e30b4f4a94d4c97855484a173e5e41951d47fcc17aef2429828b35308453835c'
  '48a09aca8b2306fe2ae650c87ba0dc9b17ae7b05ae9e7a7d8ffc247b5842c4a99dc89abf7aa1864c29c19bbf6768bcff1a3c686bf01877bf10a4838ea80d83c0'
  '9eaf77bfc1618767fd345361eb85e750c032864aafd0a6e7303a8d205a449c99cea5aecff15e99fc411e7667ecdfa20695040a7672065cd19f3fa1e1b3dde313'
  '2c41dcd9a622f948ed5409eecc485018fbf274945bdd1a9c0fdf4c4954f9a47dc311e6e0f9e445180d8b771e4a40947533d67bd66feb4ab8c8f87c2880dba7ef'
  '90fea70f21cd09bdeefe9cb6bd23677595b32156b1b8053611449504ba84a21ee1e13e5a620851299090ce989f41b97b9b4bdc98def1ccecb33115e19553c64e'
  '3cdd923781fe6446466670bce8132bbc0a1ee27ae9a76bb25bf0010c0e79c821ce1dc606405e3ffa00f22d92629aa1cd7cc680a17c98dfcf338166372b85dab1'

)

# The folder into which all projects in this file should be downloaded
MODRINTH_DIR='mods'

# The pretty name to display
MODRINTH_NAMES=(
  'Ad Astra'
  "Aurora's Decorations"
  'BCLib'
  'Better Compatibility Checker'
  'Better Fabric Console'
  'BetterEnd'
  'BetterNether'
  "Biomes O' Plenty"
  'Botarium'
  'CalcMod'
  'Concurrent Chunk Management Engine (Fabric)'
  'Explorify'
  'Faster Random'
  'Fastload'
  'FerriteCore'
  'FullStack Watchdog'
  'GlitchCore'
  'Horse Buff'
  'Lithium'
  'Mods Command'
  'Minecraft Transit Railway'
  'ModernFix'
  'Multiworld'
  "MVS - Moog's Voyager Structures"
  'Noisium'
  'Paradise Lost'
  'Prometheus (Permissions & Utilities)'
  'Quilt Kotlin Libraries (QKL)'
  'Quilted Fabric API (QFAPI) / Quilt Standard Libraries (QSL)'
  'Resourceful Config'
  'Resourceful Lib'
  'Simple Voice Chat'
  'spark'
  'Suggestion Tweaker'
  'TerraBlender'
  'ThreadTweak'
  'Towers of the Wild Modded'
  'Vanilla Refresh'
  'WorldEdit'
  "YUNG's API"
  "YUNG's Bridges"
)

# A tricky variable. This is the payload sent to Modrinth for the projects and versions you want.
# MUST be a valid JSON
# Whitespace here is strict; do not add or remove spaces or newlines
# The projects you want must have versions in this array for them to be downloaded
MODRINTH_PAYLOAD='{
  "loaders": [
    "fabric",
    "quilt"
  ],
  "game_versions": [
    "1.20.1"
  ]
}
'

# The filename whose sha512 hash download.sh compares to Modrinth's
# BUG: `find` does not like ${MINECRAFT_MINOR} or ${MINECRAFT_MAJOR} in this array
MODRINTH_WILDCARDS=(
  "ad_astra-fabric-${MINECRAFT_MINOR}-*.*.*.jar"
  "aurorasdecorations-*.*.*${MINECRAFT_MINOR}.jar"
  'bclib-*.*.*.jar'
  "BetterCompatibilityChecker-fabric-*.*.*+mc${MINECRAFT_MINOR}.jar"
  "better-fabric-console-mc${MINECRAFT_MINOR}-*.*.*.jar"
  'better-end-*.*.*.jar'
  'better-nether-*.*.*.jar'
  "BiomesOPlenty-fabric-${MINECRAFT_MINOR}-*.*.*.*.jar"
  "botarium-fabric-${MINECRAFT_MINOR}-*.*.*.jar"
  "calcmod-fabric-${MINECRAFT_MAJOR}-*.*.*.jar"
  "c2me-fabric-mc${MINECRAFT_MINOR}-*.*.*.jar"
  'Explorify\ v*.*.*\ f*-*.jar'
  'fasterrandom-*.*.*.jar'
  'Fastload+*.*.*.jar'
  'ferritecore-*.*.*-fabric.jar'
  'fullstackwatchdog-*.*.*-fabric.jar'
  "GlitchCore-fabric-${MINECRAFT_MINOR}-*.*.*.*.jar"
  "HorseBuff-${MINECRAFT_MAJOR}-*.*.*.jar"
  "lithium-fabric-mc${MINECRAFT_MINOR}-*.*.*.jar"
  "mods-command-mc${MINECRAFT_MINOR}-*.*.*.jar"
  "MTR-fabric-*.*.*+${MINECRAFT_MINOR}.jar"
  "modernfix-fabric-*.*.*+mc${MINECRAFT_MINOR}.jar"
  'Multiworld-Fabric-bundle.jar'
  "mvs-*.*.*-${MINECRAFT_MAJOR}-fabric.jar"
  'noisium-fabric-*.*.*+mc*.*.*.jar'
  'paradise-lost-*.*.*-beta+*.*.*.jar'
  "prometheus-fabric-${MINECRAFT_MINOR}-*.*.*.jar"
  'quilt-kotlin-libraries-*.*.*+kt.*.*.10+flk.*.*.*.jar'
  "qfapi-*.*.*_qsl-*.*.*_fapi-*.*.*_mc-${MINECRAFT_MINOR}.jar"
  "resourcefulconfig-fabric-${MINECRAFT_MINOR}-*.*.*.jar"
  "resourcefullib-fabric-${MINECRAFT_MINOR}-*.*.*.jar"
  "voicechat-*-${MINECRAFT_MINOR}-*.*.*.jar"
  'spark-*.*.*-fabric.jar'
  "suggestion-tweaker-${MINECRAFT_MAJOR}-*.*.*-fabric.jar"
  "TerraBlender-fabric-${MINECRAFT_MINOR}-*.*.*.*.jar"
  'threadtweak-fabric-*.*.*-*.*.*.jar'
  "totw_modded-fabric-${MINECRAFT_MINOR}-*.*.*.jar"
  'vanilla-refresh-*.*.*h.jar'
  'worldedit-mod-*.*.*.jar'
  "YungsApi-${MINECRAFT_MAJOR}-Fabric-*.*.*.jar"
  "YungsBridges-${MINECRAFT_MAJOR}-Fabric-*.*.*.jar"
)
