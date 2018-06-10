if JourneyMap.none?
  JourneyMap.new(
    title: 'Sample journey map',
  ).tap do |map|
    step_1 = map.steps.build(
      title: 'Step 1',
    )

    step_1.fields.build([
      {
        type: 'JiraField',
        contents: {
          issue_id: 10006,
        },
      },
      {
        type: 'JiraField',
        contents: {
          issue_id: 10007,
        },
      },
      {
        type: 'JiraField',
        contents: {
          issue_id: 10009,
        },
      },
      {
        type: 'JiraField',
        contents: {
          issue_id: 10010,
        },
      },
    ])

    step_2 = map.steps.build(
      title: 'Step 2',
    )

    step_2.fields.build([
      {
        type: 'JiraField',
        contents: {
          issue_id: 10008,
        },
      },
    ])

    step_3 = map.steps.build(
      title: 'Step 3',
    )

    map.save!
  end
end
