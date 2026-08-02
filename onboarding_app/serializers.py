from rest_framework import serializers


class StudentOnboardingSerializer(serializers.Serializer):
    student_name = serializers.CharField(max_length=100, min_length=2, required=True)
    age = serializers.IntegerField(min_value=3, max_value=18, required=True)
    guardian_email = serializers.EmailField(required=True)
    learning_difficulty_type = serializers.ChoiceField(
        choices=["dyslexia", "dyscalculia", "adhd", "autism_spectrum", "other"],
        required=True
    )
    region = serializers.ChoiceField(choices=["US"], required=True)

    def validate_student_name(self, value):
        if not value.replace(" ", "").isalpha():
            raise serializers.ValidationError("Invalid: name must contain letters only.")
        return value
