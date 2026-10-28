# Subject No Army（属国不造兵）

A Hearts of Iron IV mod that stops **AI-controlled subjects** from building army divisions when their **overlord is a human player**.

Supported version: **HOI4 1.19.***

[中文说明](#中文说明) | [Download](https://github.com/Drhusku/hoi4-subject-no-army/releases)

## What it does

- AI subject + human overlord -> the subject's AI wanted divisions are pushed to zero, so it stops building new army divisions.
- Works for **every autonomy level** (puppet, integrated puppet, reichskommissariat, colony, ...).
- Applies to other players' subjects in multiplayer too.
- Purely AI-side; does not touch human players' countries.

## How it works

The mod adds one AI strategy:

    ZZ_subject_no_army = {
        allowed = { always = yes }
        enable = {
            is_ai = yes
            is_subject = yes
            overlord = { is_ai = no }
        }
        abort_when_not_enabled = yes
        ai_strategy = { type = ai_wanted_divisions_factor value = -100 }
    }

ai_wanted_divisions_factor = -100 means -100% wanted divisions, so the AI stops building new army divisions. The condition is evaluated dynamically: when the country is no longer a subject, or the overlord becomes an AI, the strategy aborts by itself.

## Installation

1. Close Hearts of Iron IV.
2. Copy the Subject_No_Army folder and Subject_No_Army.mod into
   Documents\Paradox Interactive\Hearts of Iron IV\mod\
3. Enable "Subject No Army" in the launcher PlaySet and launch the game.
   On Windows you can also run install.bat, which copies the files and can update dlc_load.json for you.

## Compatibility

- HOI4 1.19.*. The ai_strategy syntax is old and stable, so it should also work on 1.15+.
- No conflicts with other mods. Mods like "Get Rid of Annoying Puppet's Troops" (which only sets units_deployed_to_overlord = no) work alongside it.
- Save-game compatible: enable it and load an existing save.

## Tuning

Edit Subject_No_Army/common/ai_strategy/zz_subject_no_army.txt and change value:

- -200 / -1000 -> stricter
- -50 -> softer

No new save needed; reload the save after the change.

## Known limitations (v1.0.0)

- Existing divisions of the subject are **not** forcibly disbanded — only stopped from growing. A future version may add daily delete_unit.
- Navy and air force are not handled.
- If the subject is already at war, it may keep the divisions it already deployed.

## Changelog

- v1.0.0 — first release. Verified in-game (HOI4 1.19.4, save SOV_1943_04_04_01): subject stopped building divisions.

## License

MIT — see [LICENSE](LICENSE).

---

## 中文说明

每次附庸一堆国家，附属国就疯狂造垃圾师团跑到你的前线抢补给？这个 mod 让「AI 控制的属国 + 宗主国是人类玩家」的属国停止建造陆军部队。

### 功能

- 只有 **AI 属国** 且 **宗主国是人类玩家** 时才生效，所有自治度等级通用（普通傀儡、集成傀儡、帝国专员辖区、殖民地……）。
- 多人局里其他人类玩家的属国同样生效。
- 纯 AI 侧逻辑，不影响人类玩家的国家。

### 原理

mod 只加了一条 AI 策略（见上面的代码块）：条件满足时把属国 AI 的期望师数压到 0（ai_wanted_divisions_factor = -100），属国就不会再新建陆军师。条件每天动态评估，属国不再是属国、或宗主变成 AI 时自动失效。

### 安装

1. 关闭游戏。
2. 把 Subject_No_Army 文件夹和 Subject_No_Army.mod 复制到
   Documents\Paradox Interactive\Hearts of Iron IV\mod\
3. 在启动器播放集里勾选 Subject No Army，启动游戏。Windows 上也可以直接双击 install.bat。

### 调参

打开 Subject_No_Army/common/ai_strategy/zz_subject_no_army.txt，把 value = -100 改成 -200 更严格、-50 更温和，读档即生效。

### 已知限制

- v1.0.0 只压制新建部队，**不强制解散已经存在的部队**（后续版本可能加每天自动解散）。
- 海军、空军暂未处理。
- 属国已在战争状态时，已经部署到前线的师可能不会被立刻收回。

### 许可证

MIT。
