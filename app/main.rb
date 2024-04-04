LOSE = "LOSE"
WIN = "WIN"

lines = ARGV

# ruby main.rb "10 5 2"のようにコマンドラインから呼び出すことを想定
# @param [String] lines ["HP 攻撃力 回復力"]
def main(lines)
  split_lines = lines[0].split.map(&:to_i)

  # 配列の定義
  hp_point = split_lines[0]
  attack_point = split_lines[1]
  heel_point = split_lines[2]

  puts "HP #{hp_point}"
  puts "攻撃力 #{attack_point}"
  puts "回復力 #{heel_point}"

  # 勝利判定、魔王のHPが攻撃力より低い場合は一撃で倒せる、また、攻撃力以上の回復力がある場合は倒せない
  judge = attack_point <= heel_point && attack_point < hp_point
  puts LOSE if judge
  exit if judge

  # ループパターンと算術パターンを行い、どちらも同じ結果であることを確認
  loop_value = loop_pattern(hp_point, attack_point, heel_point)
  arithmetic_value = arithmetic_pattern(hp_point, attack_point, heel_point)

  # ループパターンと算術パターンが同一であることで、正しいことを検証
  puts "ループパターン #{loop_value}"
  puts "算術パターン #{arithmetic_value}"

  puts WIN
  puts arithmetic_value
end

# ループパターン
def loop_pattern(hp_point, attack_point, heel_point)
  loops_needed = 0
  until hp_point <= 0
    loops_needed += 1
    hp_point -= attack_point
    # 勝利判定
    break if hp_point <= 0
    hp_point += heel_point
  end
  loops_needed
end

# 算術パターン
def arithmetic_pattern(hp_point, attack_point, heel_point)
  # 1ターンの変動値
  one_floating_value = attack_point - heel_point

  # 一撃で倒せる値
  last_boss_hp = hp_point - attack_point

  # 一撃で倒せるまでのターン数に＋1する
  turn = (last_boss_hp.to_f / one_floating_value).ceil + 1
end

main(lines)
