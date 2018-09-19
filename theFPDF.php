<?php
require('FPDF/fpdf.php');
require('FPDF/pdf.php');


$pdf=new PDF();
$pdf->AddPage();
$pdf->SetFont('Arial','B',16);
$add = "additional";
$content = "This is the file content." .$add. "\r";
$html='<table border="1">
<tr>
<td width="200" height="30">cell 1</td><td width="200" height="30" bgcolor="#D0D0FF">cell 2</td>
</tr>
<tr>
<td width="200" height="30">cell 3</td><td width="200" height="30">cell 4</td>
</tr>
</table>';
$pdf->WriteHTML($html);
$pdf->Output();
?>
