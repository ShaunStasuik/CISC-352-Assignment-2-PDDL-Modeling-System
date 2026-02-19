(define (domain Dungeon)

  (:requirements
    :typing
    :negative-preconditions
    :conditional-effects
    :equality
  )

  ; Do not modify the types
  (:types
    location colour key corridor
  )

  ; Do not modify the constants
  (:constants
    red yellow green purple rainbow - colour
  )

  (:predicates

    ; HERO STATE
    (hero-at ?loc - location)
    (holding ?k - key)
    (hand-free)

    ; CORRIDOR STRUCTURE and STATE
    (connected ?from - location ?to - location ?cor - corridor)

    ; corridor ?cor has an entrance at room ?loc
    (entrance ?cor - corridor ?loc - location)

    (locked ?cor - corridor ?col - colour)
    (risky ?cor - corridor)
    (collapsed ?cor - corridor)

    ; ROOM STATE
    (messy ?loc - location)

    ; KEY STATE
    (key-at ?k - key ?loc - location)
    (key-colour ?k - key ?col - colour)

    (one-use ?k - key)
    (two-use ?k - key)
    (multi-use ?k - key)

    (used-once ?k - key)
    (used-up ?k - key)
  )

  ; MOVE
  (:action move
    :parameters (?from ?to - location ?cor - corridor)
    :precondition (and
      (hero-at ?from)
      (connected ?from ?to ?cor)
      (not (collapsed ?cor))

      ; corridor must not be locked with any colour
      (not (locked ?cor red))
      (not (locked ?cor yellow))
      (not (locked ?cor green))
      (not (locked ?cor purple))
      (not (locked ?cor rainbow))
    )
    :effect (and
      (hero-at ?to)
      (not (hero-at ?from))

      (when (risky ?cor) (collapsed ?cor))
      (when (risky ?cor) (messy ?to))
    )
  )

  ; PICK-UP
  (:action pick-up
    :parameters (?loc - location ?k - key)
    :precondition (and
      (hero-at ?loc)
      (key-at ?k ?loc)
      (hand-free)
      (not (messy ?loc))
    )
    :effect (and
      (holding ?k)
      (not (hand-free))
      (not (key-at ?k ?loc))
    )
  )

  ; DROP
  (:action drop
    :parameters (?loc - location ?k - key)
    :precondition (and
      (hero-at ?loc)
      (holding ?k)
    )
    :effect (and
      (not (holding ?k))
      (hand-free)
      (key-at ?k ?loc)
    )
  )

  ; UNLOCK
  (:action unlock
    :parameters (?loc - location ?cor - corridor ?col - colour ?k - key)
    :precondition (and
      (hero-at ?loc)

      ; corridor must be adjacent to this room
      (entrance ?cor ?loc)

      (locked ?cor ?col)

      (holding ?k)
      (key-colour ?k ?col)

      (not (used-up ?k))
    )
    :effect (and
      ; remove the lock
      (not (locked ?cor ?col))

      ; usage tracking
      (when (one-use ?k)
        (used-up ?k)
      )

      (when (and (two-use ?k) (used-once ?k))
        (used-up ?k)
      )

      (when (and (two-use ?k) (not (used-once ?k)))
        (used-once ?k)
      )
    )
  )

  ; CLEAN
  (:action clean
    :parameters (?loc - location)
    :precondition (and
      (hero-at ?loc)
      (messy ?loc)
    )
    :effect (and
      (not (messy ?loc))
    )
  )

)
