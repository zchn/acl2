(in-package "ACL2")

(include-book "env")
(include-book "op")
(include-book "op-exec")

(defun env/step (env)
  (if (env/halted env) env
    (if (env/has-nextop env)
        (let ((nextop (env/nextop env)))
          (cond ((op/stopp nextop) (exec-stop env))
                ((op/addp  nextop) (exec-add env))
                ((op/divp  nextop) (exec-div env))
                ((op/expp  nextop) (exec-exp env))
                ((op/iszerop  nextop) (exec-iszero env))
                ((op/calldataloadp  nextop) (exec-calldataload env))
                ((op/calldatasizep  nextop) (exec-calldatasize env))
                ((op/push1p  nextop) (exec-push1 env))
                ((op/push4p  nextop) (exec-push4 env))
                ((op/dup1p  nextop) (exec-dup1 env))
                ((op/dup2p  nextop) (exec-dup2 env))
                ((op/mstorep  nextop) (exec-mstore env))
                ((op/jumpip  nextop) (exec-jumpi env))
                (t (exec-unknown env))))
      (env/set-halted env "Halted: pc out of range."))))

(defun env/exec-hacky (env max-steps)
  (if (zp max-steps) env
      (let* ((env1 (env/step env)))
        (env/exec-hacky env1 (- max-steps 1)))))

(defun env/exec (env) (env/exec-hacky env 100000))
