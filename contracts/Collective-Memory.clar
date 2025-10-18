;; Collective Memory Contract
;; Community uploads events that become immutable "time capsules"

;; Data structures
(define-map time-capsules 
  { capsule-id: uint }
  {
    creator: principal,
    title: (string-ascii 100),
    description: (string-ascii 500),
    content: (string-ascii 1000),
    timestamp: uint,
    block-height: uint
  }
)

(define-data-var next-capsule-id uint u1)

;; Constants
(define-constant CONTRACT_OWNER tx-sender)
(define-constant ERR_NOT_AUTHORIZED (err u100))
(define-constant ERR_CAPSULE_NOT_FOUND (err u101))
(define-constant ERR_INVALID_INPUT (err u102))

;; Public functions

;; Upload a new time capsule
(define-public (upload-capsule (title (string-ascii 100)) (description (string-ascii 500)) (content (string-ascii 1000)))
  (let
    (
      (capsule-id (var-get next-capsule-id))
    )
    ;; Validate inputs
    (asserts! (> (len title) u0) ERR_INVALID_INPUT)
    (asserts! (> (len description) u0) ERR_INVALID_INPUT)
    (asserts! (> (len content) u0) ERR_INVALID_INPUT)

    ;; Store the time capsule
    (map-set time-capsules 
      { capsule-id: capsule-id }
      {
        creator: tx-sender,
        title: title,
        description: description,
        content: content,
        timestamp: (unwrap-panic (get-block-info? time block-height)),
        block-height: block-height
      }
    )

    ;; Increment the next capsule ID
    (var-set next-capsule-id (+ capsule-id u1))

    (ok capsule-id)
  )
)

;; Read-only functions

;; Get a specific time capsule
(define-read-only (get-capsule (capsule-id uint))
  (map-get? time-capsules { capsule-id: capsule-id })
)

;; Get total number of capsules
(define-read-only (get-total-capsules)
  (- (var-get next-capsule-id) u1)
)

;; Check if a capsule exists
(define-read-only (capsule-exists? (capsule-id uint))
  (is-some (map-get? time-capsules { capsule-id: capsule-id }))
)

;; Get capsule creator
(define-read-only (get-capsule-creator (capsule-id uint))
  (match (map-get? time-capsules { capsule-id: capsule-id })
    capsule (some (get creator capsule))
    none
  )
)

;; Get capsule timestamp
(define-read-only (get-capsule-timestamp (capsule-id uint))
  (match (map-get? time-capsules { capsule-id: capsule-id })
    capsule (some (get timestamp capsule))
    none
  )
)