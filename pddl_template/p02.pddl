(define (problem p2-dungeon)
  (:domain Dungeon)

  (:objects
    loc-2-1 loc-1-2 loc-2-2 loc-3-2 loc-4-2 loc-2-3 - location
    key1 key2 key3 key4 - key
    c2122 c1222 c2232 c3242 c2223 - corridor
  )

  (:init
    (hero-at loc-2-2)
    (hand-free)

    ; Location <> Corridor Connections
    (connected loc-2-1 loc-2-2 c2122) (connected loc-2-2 loc-2-1 c2122)
    (connected loc-1-2 loc-2-2 c1222) (connected loc-2-2 loc-1-2 c1222)
    (connected loc-2-2 loc-3-2 c2232) (connected loc-3-2 loc-2-2 c2232)
    (connected loc-3-2 loc-4-2 c3242) (connected loc-4-2 loc-3-2 c3242)
    (connected loc-2-2 loc-2-3 c2223) (connected loc-2-3 loc-2-2 c2223)

    ; Entrances to corridors
    (entrance c2122 loc-2-1) (entrance c2122 loc-2-2)
    (entrance c1222 loc-1-2) (entrance c1222 loc-2-2)
    (entrance c2232 loc-2-2) (entrance c2232 loc-3-2)
    (entrance c3242 loc-3-2) (entrance c3242 loc-4-2)
    (entrance c2223 loc-2-2) (entrance c2223 loc-2-3)

    ; Key locations
    (key-at key1 loc-2-1)
    (key-at key2 loc-1-2)
    (key-at key3 loc-2-2)
    (key-at key4 loc-2-3)

    ; Locked corridors
    (locked c2122 purple)
    (locked c1222 yellow)
    (locked c2223 green)
    (locked c3242 rainbow)

    ; Risky corridors, red locks collapse the corridor after use
    ; none in p2

    ; Key Colours
    (key-colour key1 green)
    (key-colour key2 rainbow)
    (key-colour key3 purple)
    (key-colour key4 yellow)

    ; Key usage properties
    (one-use key1)
    (multi-use key2)
    (one-use key3)
    (two-use key4)
  )

  (:goal (and (hero-at loc-4-2)))
)