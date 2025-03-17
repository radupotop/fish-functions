# Usage: load-env-secrets env_var1 env_var2

function load-env-secrets --description "Load ENV secrets from pass store"
    for key in $argv
        if set -l password (pass show env/$key)
            set -gx $key $password
        end
    end
end
