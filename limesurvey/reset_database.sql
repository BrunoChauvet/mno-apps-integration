# Remove Answers generated for ORGANIZATION and PERSON Questions
DELETE lime_answers FROM lime_answers INNER JOIN lime_questions ON (lime_answers.qid = lime_questions.qid AND lime_questions.title IN ('ORGANIZATION', 'PERSON'));
DELETE FROM lime_participants;
DELETE FROM lime_labels WHERE mno_uid IS NOT NULL;
DELETE FROM mno_id_map;
