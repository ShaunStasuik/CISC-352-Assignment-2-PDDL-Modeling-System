(define (problem p4-dungeon)
  (:domain Dungeon)

  (:objects
    loc-1-1 loc-2-1 loc-3-1 loc-4-1 loc-5-1
    loc-5-2 loc-4-2 loc-3-2 loc-2-2 - location

    keyR keyY keyG keyP keyT - key

    c1121 c2131 c3141 c4151
    c2232 c3242 c4252
    c2122 c3132 c4142 c5152 - corridor
  )

  (:init
    (hero-at loc-1-1)
    (hand-free)

    ; Location <> Corridor Connections
    (connected loc-1-1 loc-2-1 c1121) (connected loc-2-1 loc-1-1 c1121)
    (connected loc-2-1 loc-3-1 c2131) (connected loc-3-1 loc-2-1 c2131)
    (connected loc-3-1 loc-4-1 c3141) (connected loc-4-1 loc-3-1 c3141)
    (connected loc-4-1 loc-5-1 c4151) (connected loc-5-1 loc-4-1 c4151)
    (connected loc-2-2 loc-3-2 c2232) (connected loc-3-2 loc-2-2 c2232)
    (connected loc-3-2 loc-4-2 c3242) (connected loc-4-2 loc-3-2 c3242)
    (connected loc-4-2 loc-5-2 c4252) (connected loc-5-2 loc-4-2 c4252)
    (connected loc-2-1 loc-2-2 c2122) (connected loc-2-2 loc-2-1 c2122)
    (connected loc-3-1 loc-3-2 c3132) (connected loc-3-2 loc-3-1 c3132)
    (connected loc-4-1 loc-4-2 c4142) (connected loc-4-2 loc-4-1 c4142)
    (connected loc-5-1 loc-5-2 c5152) (connected loc-5-2 loc-5-1 c5152)

    ; Entrances to corridors
    (entrance c1121 loc-1-1) (entrance c1121 loc-2-1)
    (entrance c2131 loc-2-1) (entrance c2131 loc-3-1)
    (entrance c3141 loc-3-1) (entrance c3141 loc-4-1)
    (entrance c4151 loc-4-1) (entrance c4151 loc-5-1)
    (entrance c2232 loc-2-2) (entrance c2232 loc-3-2)
    (entrance c3242 loc-3-2) (entrance c3242 loc-4-2)
    (entrance c4252 loc-4-2) (entrance c4252 loc-5-2)
    (entrance c2122 loc-2-1) (entrance c2122 loc-2-2)
    (entrance c3132 loc-3-1) (entrance c3132 loc-3-2)
    (entrance c4142 loc-4-1) (entrance c4142 loc-4-2)
    (entrance c5152 loc-5-1) (entrance c5152 loc-5-2)

    ; Key locations
    (key-at keyP loc-1-1)
    (key-at keyG loc-4-1)
    (key-at keyR loc-2-2)
    (key-at keyY loc-3-2)
    (key-at keyT loc-1-1)

    ; Locked corridors
    (locked c2131 purple)
    (locked c2122 green)
    (locked c3242 red)
    (locked c4151 yellow)
    (locked c5152 rainbow)

    ; Risky corridors, red locks collapse the corridor after use
    ; none in p4

    ; Key Colours
    (key-colour keyP purple)
    (key-colour keyG green)
    (key-colour keyR red)
    (key-colour keyY yellow)
    (key-colour keyT rainbow)

    ; Key usage properties
    (multi-use keyP)
    (multi-use keyG)
    (multi-use keyR)
    (multi-use keyY)
    (multi-use keyT)
  )

  (:goal (and (hero-at loc-5-2)))
)