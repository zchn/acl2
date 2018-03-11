(in-package "ACL2")

(include-book "std/strings/top" :dir :system)
(include-book "std/strings/pretty" :dir :system)

(include-book "env")

(defun exec-stop (env)
  (let ((tmp-env (env/set-halted env "Halted: STOP.")))
    (env/pc++ tmp-env)))

(defun exec-add (env)
  (let* ((stack (env/stack env))
         (op0 (stack/n stack 0))
         (op1 (stack/n stack 1))
         (new-stack (stack/push (stack/popn stack 2) (+ op0 op1)))
         (tmp-env (env/set-stack env new-stack))
         (new-env (env/pc++ tmp-env)))
    new-env))

(defun exec-push1 (env)
  (let* ((stack (env/stack env))
         (pc (env/pc env))
         (rom (env/rom env))
         (value-to-push (rom/n-byte rom (+ pc 1)))
         (new-stack (stack/push stack value-to-push))
         (tmp-env (env/set-stack env new-stack))
         (new-env (env/pc+n tmp-env 2)))
    new-env))

(defun exec-unknown (env)
  (let ((tmp-env
         (env/set-halted env (str::cat "Halted: unknown OP:"
                                       (str::pretty (env/nextop env))))))
    (env/pc++ tmp-env)))
