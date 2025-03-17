set AWS_SECRET_KEYS AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_DEFAULT_REGION

function aws-set-profile -d "Set AWS credentials from pass store" -a PROFILE
    if not test $PROFILE
        echo "Usage: aws-set-profile <profile_name>"
        return 1
    end
    if not set -l profile_exists (pass show aws/$PROFILE)
        return 1
    end

    for key in $AWS_SECRET_KEYS
        if set -l value (pass show aws/$PROFILE/$key)
            set -gx $key $value
        else
            return 1
        end
    end

    echo "AWS profile <$PROFILE> set successfully."
end
