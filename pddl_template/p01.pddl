(define (problem p1-dungeon)
  (:domain Dungeon)

  (:objects
    loc-3-1 loc-1-2 loc-2-2 loc-3-2 loc-4-2 loc-2-3 loc-3-3 loc-2-4 loc-3-4 loc-4-4 - location
    key1 key2 key3 key4 - key
    c3132 c1222 c2232 c3242 c2223 c3233 c2333 c2324 c3334 c2434 c3444 - corridor
  )

  (:init
    (hero-at loc-1-2)
    (hand-free)

    ; Location <> Corridor Connections
    (connected loc-3-1 loc-3-2 c3132) (connected loc-3-2 loc-3-1 c3132)
    (connected loc-1-2 loc-2-2 c1222) (connected loc-2-2 loc-1-2 c1222)
    (connected loc-2-2 loc-3-2 c2232) (connected loc-3-2 loc-2-2 c2232)
    (connected loc-3-2 loc-4-2 c3242) (connected loc-4-2 loc-3-2 c3242)
    (connected loc-2-2 loc-2-3 c2223) (connected loc-2-3 loc-2-2 c2223)
    (connected loc-3-2 loc-3-3 c3233) (connected loc-3-3 loc-3-2 c3233)
    (connected loc-2-3 loc-3-3 c2333) (connected loc-3-3 loc-2-3 c2333)
    (connected loc-2-3 loc-2-4 c2324) (connected loc-2-4 loc-2-3 c2324)
    (connected loc-3-3 loc-3-4 c3334) (connected loc-3-4 loc-3-3 c3334)
    (connected loc-2-4 loc-3-4 c2434) (connected loc-3-4 loc-2-4 c2434)
    (connected loc-3-4 loc-4-4 c3444) (connected loc-4-4 loc-3-4 c3444)

    ; Entrances to corridors
    (entrance c3132 loc-3-1) (entrance c3132 loc-3-2)
    (entrance c1222 loc-1-2) (entrance c1222 loc-2-2)
    (entrance c2232 loc-2-2) (entrance c2232 loc-3-2)
    (entrance c3242 loc-3-2) (entrance c3242 loc-4-2)
    (entrance c2223 loc-2-2) (entrance c2223 loc-2-3)
    (entrance c3233 loc-3-2) (entrance c3233 loc-3-3)
    (entrance c2333 loc-2-3) (entrance c2333 loc-3-3)
    (entrance c2324 loc-2-3) (entrance c2324 loc-2-4)
    (entrance c3334 loc-3-3) (entrance c3334 loc-3-4)
    (entrance c2434 loc-2-4) (entrance c2434 loc-3-4)
    (entrance c3444 loc-3-4) (entrance c3444 loc-4-4)

    ; Key locations
    (key-at key1 loc-1-2)
    (key-at key2 loc-2-4)
    (key-at key3 loc-4-2)
    (key-at key4 loc-2-3)

    ; Locked corridors
    (locked c1222 red)
    (locked c3242 yellow)
    (locked c2333 purple)
    (locked c3132 rainbow)

    ; Risky corridors, red locks collapse the corridor after use
    (risky c1222)

    ; Key Colours
    (key-colour key1 red)
    (key-colour key2 yellow)
    (key-colour key3 rainbow)
    (key-colour key4 purple)

    ; Key usage properties
    (multi-use key1)
    (two-use key2)
    (one-use key3)
    (one-use key4)
  )

  (:goal (and (hero-at loc-3-1)))
)