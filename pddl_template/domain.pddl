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
    ;Hero can move if the
    ;    - hero is at current location ?from,
    ;    - hero will move to location ?to,
    ;    - corridor ?cor exists between the ?from and ?to locations
    ;    - there isn't a locked door in corridor ?cor
    ;Effects move the hero, and collapse the corridor if it's "risky" (also causing a mess in the ?to location)
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
  ;Hero can pick up a key if the
    ;    - hero is at current location ?loc,
    ;    - there is a key ?k at location ?loc,
    ;    - the hero's arm is free,
    ;    - the location is not messy
    ;Effect will have the hero holding the key and their arm no longer being free
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
  ;Hero can drop a key if the
    ;    - hero is holding a key ?k,
    ;    - the hero is at location ?loc
    ;Effect will be that the hero is no longer holding the key
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
  ;Hero can use a key for a corridor if
    ;    - the hero is holding a key ?k,
    ;    - the key still has some uses left,
    ;    - the corridor ?cor is locked with colour ?col,
    ;    - the key ?k is if the right colour ?col,
    ;    - the hero is at location ?loc
    ;    - the corridor is connected to the location ?loc
    ;Effect will be that the corridor is unlocked and the key usage will be updated if necessary
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
  ;Hero can clean a location if
    ;    - the hero is at location ?loc,
    ;    - the location is messy
    ;Effect will be that the location is no longer messy
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
