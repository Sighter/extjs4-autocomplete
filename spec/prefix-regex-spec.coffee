describe "Regex used to get prefix", ->

  regex = /[\w0-9_.-]+$/

  it "should give the right suggestions", ->

    line = "var panel = Ext.cr"
    expect(line.match(regex)?[0]).toBe('Ext.cr')

    line = "var panel = Ext.create('Lier."
    expect(line.match(regex)?[0]).toBe('Lier.')
