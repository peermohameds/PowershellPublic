---
external help file: Jumpstart-help.xml
Module Name: Jumpstart
online version:
schema: 2.0.0
---

# Add-Number

## SYNOPSIS
Add-Number function adds given integers

## SYNTAX

```
Add-Number [[-A] <Int32>] [[-B] <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Add-Number adds the numbers which are given as parameters.

## EXAMPLES

### Example 1
```powershell
PS C:\>Add-Number -A 10 -B 20
30
```

Add-Number function adds given integers 10 and 20, displays the result 30

## PARAMETERS

### -A
an integer type to be given as prameter A. Which can be between 10-20

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -B
An integer second number

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
