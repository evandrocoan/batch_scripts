from pptx import Presentation
import fix_slides_for_obs_processor as processor

prs = Presentation('Apresentação1Original.pptx')
result = processor.reposition_and_maximize_font(prs)
print(f'Slides processed: {result["slides_processed"]}')
prs.save('test_output.pptx')
print('Saved to test_output.pptx')
