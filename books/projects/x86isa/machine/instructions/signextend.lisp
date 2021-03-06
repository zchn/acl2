;; AUTHOR:
;; Shilpi Goel <shigoel@cs.utexas.edu>

(in-package "X86ISA")

;; ======================================================================

(include-book "../decoding-and-spec-utils"
              :ttags (:include-raw :syscall-exec :other-non-det :undef-flg))
(local (include-book "centaur/bitops/ihs-extensions" :dir :system))

;; ======================================================================
;; INSTRUCTION: CBW/CWDE/CDQE/CLTQ
;; ======================================================================

(def-inst x86-cbw/cwd/cdqe

  ;; Op/En: NP

  ;; #x98: CBW:   AX  := Sign-extended AL
  ;; #x98: CWDE:  EAX := Sign-extended AX
  ;; #x98: CDQE:  RAX := Sign-extended EAX

  :parents (one-byte-opcodes)
  :returns (x86 x86p :hyp (and (x86p x86)
                               (canonical-address-p temp-rip)))
  :guard-hints (("Goal" :in-theory (e/d (n08-to-i08
                                         n16-to-i16
                                         n32-to-i32
                                         n64-to-i64)
                                        ())))
  :implemented
  (add-to-implemented-opcodes-table 'CBW #x98 '(:nil nil)
                                    'x86-cbw/cwd/cdqe)

  :body

  (b* ((ctx 'x86-cbw/cwd/cdqe)
       (lock? (equal #.*lock* (prefixes-slice :group-1-prefix prefixes)))
       ((when lock?)
        (!!ms-fresh :lock-prefix prefixes))

       ((the (signed-byte #.*max-linear-address-size+1*) addr-diff)
        (-
         (the (signed-byte #.*max-linear-address-size*)
           temp-rip)
         (the (signed-byte #.*max-linear-address-size*)
           start-rip)))
       ((when (< 15 addr-diff))
        (!!ms-fresh :instruction-length addr-diff))

       ((the (integer 1 8) register-size)
        (select-operand-size nil rex-byte nil prefixes))
       ((the (integer 1 4) src-size) (ash register-size -1))
       ((the (unsigned-byte 32) src)
        (mbe :logic
             (rgfi-size src-size *rax* rex-byte x86)
             :exec
             (case src-size
               (1 (rr08 *rax* rex-byte x86))
               (2 (rr16 *rax* x86))
               (4 (rr32 *rax* x86))
               (otherwise 0))))
       (dst (if (logbitp (the (integer 0 32)
                           (1- (the (integer 0 32) (ash src-size 3))))
                         src)
                (trunc register-size (case src-size
                                       (1 (n08-to-i08 src))
                                       (2 (n16-to-i16 src))
                                       (t (n32-to-i32 src))))
              src))
       ;; Update the x86 state:
       (x86 (!rgfi-size register-size *rax* dst rex-byte x86))
       (x86 (!rip temp-rip x86)))
    x86))

;; ======================================================================
;; INSTRUCTION: CWD/CDQ/CQO
;; ======================================================================

(def-inst x86-cwd/cdq/cqo

  ;; Op/En: NP

  ;; #x99: CWD:  DX:AX   := Sign-extended AX
  ;; #x99: CDQ:  EDX:EAX := Sign-extended EAX
  ;; #x99: CQO:  RDX:RAX := Sign-extended RAX

  :parents (one-byte-opcodes)

  :returns (x86 x86p :hyp (and (x86p x86)
                               (canonical-address-p temp-rip)))
  :implemented
  (add-to-implemented-opcodes-table 'CWD #x99 '(:nil nil) 'x86-cwd/cdq/cqo)

  :body

  (b* ((ctx 'x86-cwd/cdq/cqo)
       (lock? (equal #.*lock* (prefixes-slice :group-1-prefix prefixes)))
       ((when lock?)
        (!!ms-fresh :lock-prefix prefixes))

       ((the (signed-byte #.*max-linear-address-size+1*) addr-diff)
        (-
         (the (signed-byte #.*max-linear-address-size*)
           temp-rip)
         (the (signed-byte #.*max-linear-address-size*)
           start-rip)))
       ((when (< 15 addr-diff))
        (!!ms-fresh :instruction-length addr-diff))

       ((the (integer 1 8) src-size)
        (select-operand-size nil rex-byte nil prefixes))
       (src (rgfi-size src-size *rax* rex-byte x86))
       (rDX (if (logbitp (1- (ash src-size 3)) src)
                (trunc src-size -1)
              0))
       ;; Update the x86 state:
       (x86 (!rgfi-size src-size *rdx* rDX rex-byte x86))
       (x86 (!rip temp-rip x86)))
      x86))

;; ======================================================================
