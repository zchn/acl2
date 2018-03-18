(in-package "ACL2")

;; The word size of the machine (and thus size of stack items) is 256-bit. The
;; stack has a maximum size of 1024.

(defun mk-empty-stack () (list 'stack-bottom))

(defun stack/validp (stack) (listp stack))

(defun stack/push (stack v)
  (cons v stack))

(defun stack/popn (stack n)
  (subseq stack n nil))

(defun stack/n (stack n)
  (car (stack/popn stack n)))
