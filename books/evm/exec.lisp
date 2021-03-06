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
                ((op/mulp  nextop) (exec-mul env))
                ((op/subp  nextop) (exec-sub env))
                ((op/divp  nextop) (exec-div env))
                ((op/expp  nextop) (exec-exp env))
                ((op/ltp  nextop) (exec-lt env))
                ((op/gtp  nextop) (exec-gt env))
                ((op/eqp  nextop) (exec-eq env))
                ((op/iszerop  nextop) (exec-iszero env))
                ((op/andp  nextop) (exec-and env))
                ((op/orp  nextop) (exec-or env))
                ((op/xorp  nextop) (exec-xor env))
                ((op/notp  nextop) (exec-not env))
                ((op/callerp  nextop) (exec-caller env))
                ((op/callvaluep  nextop) (exec-callvalue env))
                ((op/calldataloadp  nextop) (exec-calldataload env))
                ((op/calldatasizep  nextop) (exec-calldatasize env))
                ((op/codecopyp  nextop) (exec-codecopy env))
                ((op/push1p  nextop) (exec-push1 env))
                ((op/push2p  nextop) (exec-push2 env))
                ((op/push4p  nextop) (exec-push4 env))
                ((op/push29p  nextop) (exec-push29 env))
                ((op/push32p  nextop) (exec-push32 env))
                ((op/dup1p  nextop) (exec-dup1 env))
                ((op/dup2p  nextop) (exec-dup2 env))
                ((op/mstorep  nextop) (exec-mstore env))
                ((op/jumpp  nextop) (exec-jump env))
                ((op/jumpip  nextop) (exec-jumpi env))
                ((op/jumpdestp  nextop) (exec-jumpdest env))
                ((op/swap1p  nextop) (exec-swap1 env))
                ((op/log0p  nextop) (exec-log0 env))
                ((op/log1p  nextop) (exec-log1 env))
                ((op/log2p  nextop) (exec-log2 env))
                ((op/log3p  nextop) (exec-log3 env))
                ((op/log4p  nextop) (exec-log4 env))
                ((op/revertp  nextop) (exec-revert env))
                ((op/returnp  nextop) (exec-return env))
                (t (exec-unknown env))))
      (env/set-halted env "Halted: pc out of range."))))

(defun env/exec-hacky (env max-steps)
  (if (zp max-steps) env
      (let* ((env1 (env/step env)))
        (env/exec-hacky env1 (- max-steps 1)))))

(defun env/exec (env) (env/exec-hacky env 100000))
