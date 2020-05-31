
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc c0 b5 10 80       	mov    $0x8010b5c0,%esp
8010002d:	b8 f0 2d 10 80       	mov    $0x80102df0,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
80100049:	83 ec 14             	sub    $0x14,%esp
8010004c:	c7 44 24 04 20 70 10 	movl   $0x80107020,0x4(%esp)
80100053:	80 
80100054:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010005b:	e8 00 43 00 00       	call   80104360 <initlock>
80100060:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx
80100065:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
8010006c:	fc 10 80 
8010006f:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
80100076:	fc 10 80 
80100079:	eb 09                	jmp    80100084 <binit+0x44>
8010007b:	90                   	nop
8010007c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 da                	mov    %ebx,%edx
80100082:	89 c3                	mov    %eax,%ebx
80100084:	8d 43 0c             	lea    0xc(%ebx),%eax
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
8010008a:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
80100091:	89 04 24             	mov    %eax,(%esp)
80100094:	c7 44 24 04 27 70 10 	movl   $0x80107027,0x4(%esp)
8010009b:	80 
8010009c:	e8 8f 41 00 00       	call   80104230 <initsleeplock>
801000a1:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
801000a6:	89 58 50             	mov    %ebx,0x50(%eax)
801000a9:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000af:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
801000b4:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
801000ba:	75 c4                	jne    80100080 <binit+0x40>
801000bc:	83 c4 14             	add    $0x14,%esp
801000bf:	5b                   	pop    %ebx
801000c0:	5d                   	pop    %ebp
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 1c             	sub    $0x1c,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
801000e3:	8b 7d 0c             	mov    0xc(%ebp),%edi
801000e6:	e8 e5 43 00 00       	call   801044d0 <acquire>
801000eb:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000f1:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	90                   	nop
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 58                	jmp    80100188 <bread+0xb8>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 4d                	je     80100188 <bread+0xb8>
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
8010015a:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100161:	e8 da 43 00 00       	call   80104540 <release>
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 ff 40 00 00       	call   80104270 <acquiresleep>
80100171:	f6 03 02             	testb  $0x2,(%ebx)
80100174:	75 08                	jne    8010017e <bread+0xae>
80100176:	89 1c 24             	mov    %ebx,(%esp)
80100179:	e8 a2 1f 00 00       	call   80102120 <iderw>
8010017e:	83 c4 1c             	add    $0x1c,%esp
80100181:	89 d8                	mov    %ebx,%eax
80100183:	5b                   	pop    %ebx
80100184:	5e                   	pop    %esi
80100185:	5f                   	pop    %edi
80100186:	5d                   	pop    %ebp
80100187:	c3                   	ret    
80100188:	c7 04 24 2e 70 10 80 	movl   $0x8010702e,(%esp)
8010018f:	e8 cc 01 00 00       	call   80100360 <panic>
80100194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010019a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801001a0 <bwrite>:
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 14             	sub    $0x14,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	89 04 24             	mov    %eax,(%esp)
801001b0:	e8 5b 41 00 00       	call   80104310 <holdingsleep>
801001b5:	85 c0                	test   %eax,%eax
801001b7:	74 10                	je     801001c9 <bwrite+0x29>
801001b9:	83 0b 04             	orl    $0x4,(%ebx)
801001bc:	89 5d 08             	mov    %ebx,0x8(%ebp)
801001bf:	83 c4 14             	add    $0x14,%esp
801001c2:	5b                   	pop    %ebx
801001c3:	5d                   	pop    %ebp
801001c4:	e9 57 1f 00 00       	jmp    80102120 <iderw>
801001c9:	c7 04 24 3f 70 10 80 	movl   $0x8010703f,(%esp)
801001d0:	e8 8b 01 00 00       	call   80100360 <panic>
801001d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	83 ec 10             	sub    $0x10,%esp
801001e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	89 34 24             	mov    %esi,(%esp)
801001f1:	e8 1a 41 00 00       	call   80104310 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5b                	je     80100255 <brelse+0x75>
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 ce 40 00 00       	call   801042d0 <releasesleep>
80100202:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100209:	e8 c2 42 00 00       	call   801044d0 <acquire>
8010020e:	83 6b 4c 01          	subl   $0x1,0x4c(%ebx)
80100212:	75 2f                	jne    80100243 <brelse+0x63>
80100214:	8b 43 54             	mov    0x54(%ebx),%eax
80100217:	8b 53 50             	mov    0x50(%ebx),%edx
8010021a:	89 50 50             	mov    %edx,0x50(%eax)
8010021d:	8b 43 50             	mov    0x50(%ebx),%eax
80100220:	8b 53 54             	mov    0x54(%ebx),%edx
80100223:	89 50 54             	mov    %edx,0x54(%eax)
80100226:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
8010022b:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
80100232:	89 43 54             	mov    %eax,0x54(%ebx)
80100235:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
8010023a:	89 58 50             	mov    %ebx,0x50(%eax)
8010023d:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
80100243:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
8010024a:	83 c4 10             	add    $0x10,%esp
8010024d:	5b                   	pop    %ebx
8010024e:	5e                   	pop    %esi
8010024f:	5d                   	pop    %ebp
80100250:	e9 eb 42 00 00       	jmp    80104540 <release>
80100255:	c7 04 24 46 70 10 80 	movl   $0x80107046,(%esp)
8010025c:	e8 ff 00 00 00       	call   80100360 <panic>
80100261:	66 90                	xchg   %ax,%ax
80100263:	66 90                	xchg   %ax,%ax
80100265:	66 90                	xchg   %ax,%ax
80100267:	66 90                	xchg   %ax,%ax
80100269:	66 90                	xchg   %ax,%ax
8010026b:	66 90                	xchg   %ax,%ax
8010026d:	66 90                	xchg   %ax,%ax
8010026f:	90                   	nop

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 1c             	sub    $0x1c,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	89 3c 24             	mov    %edi,(%esp)
80100282:	e8 09 15 00 00       	call   80101790 <iunlock>
  target = n;
  acquire(&cons.lock);
80100287:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028e:	e8 3d 42 00 00       	call   801044d0 <acquire>
  while(n > 0){
80100293:	8b 55 10             	mov    0x10(%ebp),%edx
80100296:	85 d2                	test   %edx,%edx
80100298:	0f 8e bc 00 00 00    	jle    8010035a <consoleread+0xea>
8010029e:	8b 5d 10             	mov    0x10(%ebp),%ebx
801002a1:	eb 25                	jmp    801002c8 <consoleread+0x58>
801002a3:	90                   	nop
801002a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(input.r == input.w){
      if(myproc()->killed){
801002a8:	e8 43 34 00 00       	call   801036f0 <myproc>
801002ad:	8b 40 24             	mov    0x24(%eax),%eax
801002b0:	85 c0                	test   %eax,%eax
801002b2:	75 74                	jne    80100328 <consoleread+0xb8>
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b4:	c7 44 24 04 20 a5 10 	movl   $0x8010a520,0x4(%esp)
801002bb:	80 
801002bc:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
801002c3:	e8 d8 3a 00 00       	call   80103da0 <sleep>
    while(input.r == input.w){
801002c8:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002cd:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002d3:	74 d3                	je     801002a8 <consoleread+0x38>
    }
    c = input.buf[input.r++ % INPUT_BUF];
801002d5:	8d 50 01             	lea    0x1(%eax),%edx
801002d8:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
801002de:	89 c2                	mov    %eax,%edx
801002e0:	83 e2 7f             	and    $0x7f,%edx
801002e3:	0f b6 8a 20 ff 10 80 	movzbl -0x7fef00e0(%edx),%ecx
801002ea:	0f be d1             	movsbl %cl,%edx
    if(c == C('D')){  // EOF
801002ed:	83 fa 04             	cmp    $0x4,%edx
801002f0:	74 57                	je     80100349 <consoleread+0xd9>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002f2:	83 c6 01             	add    $0x1,%esi
    --n;
801002f5:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
801002f8:	83 fa 0a             	cmp    $0xa,%edx
    *dst++ = c;
801002fb:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
801002fe:	74 53                	je     80100353 <consoleread+0xe3>
  while(n > 0){
80100300:	85 db                	test   %ebx,%ebx
80100302:	75 c4                	jne    801002c8 <consoleread+0x58>
80100304:	8b 45 10             	mov    0x10(%ebp),%eax
      break;
  }
  release(&cons.lock);
80100307:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010030e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100311:	e8 2a 42 00 00       	call   80104540 <release>
  ilock(ip);
80100316:	89 3c 24             	mov    %edi,(%esp)
80100319:	e8 92 13 00 00       	call   801016b0 <ilock>
8010031e:	8b 45 e4             	mov    -0x1c(%ebp),%eax

  return target - n;
80100321:	eb 1e                	jmp    80100341 <consoleread+0xd1>
80100323:	90                   	nop
80100324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        release(&cons.lock);
80100328:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010032f:	e8 0c 42 00 00       	call   80104540 <release>
        ilock(ip);
80100334:	89 3c 24             	mov    %edi,(%esp)
80100337:	e8 74 13 00 00       	call   801016b0 <ilock>
        return -1;
8010033c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100341:	83 c4 1c             	add    $0x1c,%esp
80100344:	5b                   	pop    %ebx
80100345:	5e                   	pop    %esi
80100346:	5f                   	pop    %edi
80100347:	5d                   	pop    %ebp
80100348:	c3                   	ret    
      if(n < target){
80100349:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010034c:	76 05                	jbe    80100353 <consoleread+0xe3>
        input.r--;
8010034e:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
80100353:	8b 45 10             	mov    0x10(%ebp),%eax
80100356:	29 d8                	sub    %ebx,%eax
80100358:	eb ad                	jmp    80100307 <consoleread+0x97>
  while(n > 0){
8010035a:	31 c0                	xor    %eax,%eax
8010035c:	eb a9                	jmp    80100307 <consoleread+0x97>
8010035e:	66 90                	xchg   %ax,%ax

80100360 <panic>:
{
80100360:	55                   	push   %ebp
80100361:	89 e5                	mov    %esp,%ebp
80100363:	56                   	push   %esi
80100364:	53                   	push   %ebx
80100365:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100368:	fa                   	cli    
  cons.locking = 0;
80100369:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100370:	00 00 00 
  getcallerpcs(&s, pcs);
80100373:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  cprintf("lapicid %d: panic: ", lapicid());
80100376:	e8 e5 23 00 00       	call   80102760 <lapicid>
8010037b:	8d 75 f8             	lea    -0x8(%ebp),%esi
8010037e:	c7 04 24 4d 70 10 80 	movl   $0x8010704d,(%esp)
80100385:	89 44 24 04          	mov    %eax,0x4(%esp)
80100389:	e8 c2 02 00 00       	call   80100650 <cprintf>
  cprintf(s);
8010038e:	8b 45 08             	mov    0x8(%ebp),%eax
80100391:	89 04 24             	mov    %eax,(%esp)
80100394:	e8 b7 02 00 00       	call   80100650 <cprintf>
  cprintf("\n");
80100399:	c7 04 24 1a 76 10 80 	movl   $0x8010761a,(%esp)
801003a0:	e8 ab 02 00 00       	call   80100650 <cprintf>
  getcallerpcs(&s, pcs);
801003a5:	8d 45 08             	lea    0x8(%ebp),%eax
801003a8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ac:	89 04 24             	mov    %eax,(%esp)
801003af:	e8 cc 3f 00 00       	call   80104380 <getcallerpcs>
801003b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003b8:	8b 03                	mov    (%ebx),%eax
801003ba:	83 c3 04             	add    $0x4,%ebx
801003bd:	c7 04 24 61 70 10 80 	movl   $0x80107061,(%esp)
801003c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801003c8:	e8 83 02 00 00       	call   80100650 <cprintf>
  for(i=0; i<10; i++)
801003cd:	39 f3                	cmp    %esi,%ebx
801003cf:	75 e7                	jne    801003b8 <panic+0x58>
  panicked = 1; // freeze other CPU
801003d1:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003d8:	00 00 00 
801003db:	eb fe                	jmp    801003db <panic+0x7b>
801003dd:	8d 76 00             	lea    0x0(%esi),%esi

801003e0 <consputc>:
  if(panicked){
801003e0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003e6:	85 d2                	test   %edx,%edx
801003e8:	74 06                	je     801003f0 <consputc+0x10>
801003ea:	fa                   	cli    
801003eb:	eb fe                	jmp    801003eb <consputc+0xb>
801003ed:	8d 76 00             	lea    0x0(%esi),%esi
{
801003f0:	55                   	push   %ebp
801003f1:	89 e5                	mov    %esp,%ebp
801003f3:	57                   	push   %edi
801003f4:	56                   	push   %esi
801003f5:	53                   	push   %ebx
801003f6:	89 c3                	mov    %eax,%ebx
801003f8:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
801003fb:	3d 00 01 00 00       	cmp    $0x100,%eax
80100400:	0f 84 ac 00 00 00    	je     801004b2 <consputc+0xd2>
    uartputc(c);
80100406:	89 04 24             	mov    %eax,(%esp)
80100409:	e8 72 57 00 00       	call   80105b80 <uartputc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010040e:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100413:	b8 0e 00 00 00       	mov    $0xe,%eax
80100418:	89 fa                	mov    %edi,%edx
8010041a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010041b:	be d5 03 00 00       	mov    $0x3d5,%esi
80100420:	89 f2                	mov    %esi,%edx
80100422:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100423:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100426:	89 fa                	mov    %edi,%edx
80100428:	c1 e1 08             	shl    $0x8,%ecx
8010042b:	b8 0f 00 00 00       	mov    $0xf,%eax
80100430:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100431:	89 f2                	mov    %esi,%edx
80100433:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100434:	0f b6 c0             	movzbl %al,%eax
80100437:	09 c1                	or     %eax,%ecx
  if(c == '\n')
80100439:	83 fb 0a             	cmp    $0xa,%ebx
8010043c:	0f 84 0d 01 00 00    	je     8010054f <consputc+0x16f>
  else if(c == BACKSPACE){
80100442:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100448:	0f 84 e8 00 00 00    	je     80100536 <consputc+0x156>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010044e:	0f b6 db             	movzbl %bl,%ebx
80100451:	80 cf 07             	or     $0x7,%bh
80100454:	8d 79 01             	lea    0x1(%ecx),%edi
80100457:	66 89 9c 09 00 80 0b 	mov    %bx,-0x7ff48000(%ecx,%ecx,1)
8010045e:	80 
  if(pos < 0 || pos > 25*80)
8010045f:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
80100465:	0f 87 bf 00 00 00    	ja     8010052a <consputc+0x14a>
  if((pos/80) >= 24){  // Scroll up.
8010046b:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100471:	7f 68                	jg     801004db <consputc+0xfb>
80100473:	89 f8                	mov    %edi,%eax
80100475:	89 fb                	mov    %edi,%ebx
80100477:	c1 e8 08             	shr    $0x8,%eax
8010047a:	89 c6                	mov    %eax,%esi
8010047c:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100483:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100488:	b8 0e 00 00 00       	mov    $0xe,%eax
8010048d:	89 fa                	mov    %edi,%edx
8010048f:	ee                   	out    %al,(%dx)
80100490:	89 f0                	mov    %esi,%eax
80100492:	b2 d5                	mov    $0xd5,%dl
80100494:	ee                   	out    %al,(%dx)
80100495:	b8 0f 00 00 00       	mov    $0xf,%eax
8010049a:	89 fa                	mov    %edi,%edx
8010049c:	ee                   	out    %al,(%dx)
8010049d:	89 d8                	mov    %ebx,%eax
8010049f:	b2 d5                	mov    $0xd5,%dl
801004a1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004a2:	b8 20 07 00 00       	mov    $0x720,%eax
801004a7:	66 89 01             	mov    %ax,(%ecx)
}
801004aa:	83 c4 1c             	add    $0x1c,%esp
801004ad:	5b                   	pop    %ebx
801004ae:	5e                   	pop    %esi
801004af:	5f                   	pop    %edi
801004b0:	5d                   	pop    %ebp
801004b1:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004b2:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004b9:	e8 c2 56 00 00       	call   80105b80 <uartputc>
801004be:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004c5:	e8 b6 56 00 00       	call   80105b80 <uartputc>
801004ca:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004d1:	e8 aa 56 00 00       	call   80105b80 <uartputc>
801004d6:	e9 33 ff ff ff       	jmp    8010040e <consputc+0x2e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004db:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004e2:	00 
    pos -= 80;
801004e3:	8d 5f b0             	lea    -0x50(%edi),%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004e6:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004ed:	80 
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004ee:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f5:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
801004fc:	e8 2f 41 00 00       	call   80104630 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100501:	b8 d0 07 00 00       	mov    $0x7d0,%eax
80100506:	29 f8                	sub    %edi,%eax
80100508:	01 c0                	add    %eax,%eax
8010050a:	89 34 24             	mov    %esi,(%esp)
8010050d:	89 44 24 08          	mov    %eax,0x8(%esp)
80100511:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100518:	00 
80100519:	e8 72 40 00 00       	call   80104590 <memset>
8010051e:	89 f1                	mov    %esi,%ecx
80100520:	be 07 00 00 00       	mov    $0x7,%esi
80100525:	e9 59 ff ff ff       	jmp    80100483 <consputc+0xa3>
    panic("pos under/overflow");
8010052a:	c7 04 24 65 70 10 80 	movl   $0x80107065,(%esp)
80100531:	e8 2a fe ff ff       	call   80100360 <panic>
    if(pos > 0) --pos;
80100536:	85 c9                	test   %ecx,%ecx
80100538:	8d 79 ff             	lea    -0x1(%ecx),%edi
8010053b:	0f 85 1e ff ff ff    	jne    8010045f <consputc+0x7f>
80100541:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
80100546:	31 db                	xor    %ebx,%ebx
80100548:	31 f6                	xor    %esi,%esi
8010054a:	e9 34 ff ff ff       	jmp    80100483 <consputc+0xa3>
    pos += 80 - pos%80;
8010054f:	89 c8                	mov    %ecx,%eax
80100551:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100556:	f7 ea                	imul   %edx
80100558:	c1 ea 05             	shr    $0x5,%edx
8010055b:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010055e:	c1 e0 04             	shl    $0x4,%eax
80100561:	8d 78 50             	lea    0x50(%eax),%edi
80100564:	e9 f6 fe ff ff       	jmp    8010045f <consputc+0x7f>
80100569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100570 <printint>:
{
80100570:	55                   	push   %ebp
80100571:	89 e5                	mov    %esp,%ebp
80100573:	57                   	push   %edi
80100574:	56                   	push   %esi
80100575:	89 d6                	mov    %edx,%esi
80100577:	53                   	push   %ebx
80100578:	83 ec 1c             	sub    $0x1c,%esp
  if(sign && (sign = xx < 0))
8010057b:	85 c9                	test   %ecx,%ecx
8010057d:	74 61                	je     801005e0 <printint+0x70>
8010057f:	85 c0                	test   %eax,%eax
80100581:	79 5d                	jns    801005e0 <printint+0x70>
    x = -xx;
80100583:	f7 d8                	neg    %eax
80100585:	bf 01 00 00 00       	mov    $0x1,%edi
  i = 0;
8010058a:	31 c9                	xor    %ecx,%ecx
8010058c:	eb 04                	jmp    80100592 <printint+0x22>
8010058e:	66 90                	xchg   %ax,%ax
    buf[i++] = digits[x % base];
80100590:	89 d9                	mov    %ebx,%ecx
80100592:	31 d2                	xor    %edx,%edx
80100594:	f7 f6                	div    %esi
80100596:	8d 59 01             	lea    0x1(%ecx),%ebx
80100599:	0f b6 92 90 70 10 80 	movzbl -0x7fef8f70(%edx),%edx
  }while((x /= base) != 0);
801005a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005a2:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
801005a6:	75 e8                	jne    80100590 <printint+0x20>
  if(sign)
801005a8:	85 ff                	test   %edi,%edi
    buf[i++] = digits[x % base];
801005aa:	89 d8                	mov    %ebx,%eax
  if(sign)
801005ac:	74 08                	je     801005b6 <printint+0x46>
    buf[i++] = '-';
801005ae:	8d 59 02             	lea    0x2(%ecx),%ebx
801005b1:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
  while(--i >= 0)
801005b6:	83 eb 01             	sub    $0x1,%ebx
801005b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i]);
801005c0:	0f be 44 1d d8       	movsbl -0x28(%ebp,%ebx,1),%eax
  while(--i >= 0)
801005c5:	83 eb 01             	sub    $0x1,%ebx
    consputc(buf[i]);
801005c8:	e8 13 fe ff ff       	call   801003e0 <consputc>
  while(--i >= 0)
801005cd:	83 fb ff             	cmp    $0xffffffff,%ebx
801005d0:	75 ee                	jne    801005c0 <printint+0x50>
}
801005d2:	83 c4 1c             	add    $0x1c,%esp
801005d5:	5b                   	pop    %ebx
801005d6:	5e                   	pop    %esi
801005d7:	5f                   	pop    %edi
801005d8:	5d                   	pop    %ebp
801005d9:	c3                   	ret    
801005da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    x = xx;
801005e0:	31 ff                	xor    %edi,%edi
801005e2:	eb a6                	jmp    8010058a <printint+0x1a>
801005e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801005f0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005f0:	55                   	push   %ebp
801005f1:	89 e5                	mov    %esp,%ebp
801005f3:	57                   	push   %edi
801005f4:	56                   	push   %esi
801005f5:	53                   	push   %ebx
801005f6:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
801005f9:	8b 45 08             	mov    0x8(%ebp),%eax
{
801005fc:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
801005ff:	89 04 24             	mov    %eax,(%esp)
80100602:	e8 89 11 00 00       	call   80101790 <iunlock>
  acquire(&cons.lock);
80100607:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010060e:	e8 bd 3e 00 00       	call   801044d0 <acquire>
80100613:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100616:	85 f6                	test   %esi,%esi
80100618:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010061b:	7e 12                	jle    8010062f <consolewrite+0x3f>
8010061d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100620:	0f b6 07             	movzbl (%edi),%eax
80100623:	83 c7 01             	add    $0x1,%edi
80100626:	e8 b5 fd ff ff       	call   801003e0 <consputc>
  for(i = 0; i < n; i++)
8010062b:	39 df                	cmp    %ebx,%edi
8010062d:	75 f1                	jne    80100620 <consolewrite+0x30>
  release(&cons.lock);
8010062f:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100636:	e8 05 3f 00 00       	call   80104540 <release>
  ilock(ip);
8010063b:	8b 45 08             	mov    0x8(%ebp),%eax
8010063e:	89 04 24             	mov    %eax,(%esp)
80100641:	e8 6a 10 00 00       	call   801016b0 <ilock>

  return n;
}
80100646:	83 c4 1c             	add    $0x1c,%esp
80100649:	89 f0                	mov    %esi,%eax
8010064b:	5b                   	pop    %ebx
8010064c:	5e                   	pop    %esi
8010064d:	5f                   	pop    %edi
8010064e:	5d                   	pop    %ebp
8010064f:	c3                   	ret    

80100650 <cprintf>:
{
80100650:	55                   	push   %ebp
80100651:	89 e5                	mov    %esp,%ebp
80100653:	57                   	push   %edi
80100654:	56                   	push   %esi
80100655:	53                   	push   %ebx
80100656:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100659:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010065e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100660:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100663:	0f 85 27 01 00 00    	jne    80100790 <cprintf+0x140>
  if (fmt == 0)
80100669:	8b 45 08             	mov    0x8(%ebp),%eax
8010066c:	85 c0                	test   %eax,%eax
8010066e:	89 c1                	mov    %eax,%ecx
80100670:	0f 84 2b 01 00 00    	je     801007a1 <cprintf+0x151>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100676:	0f b6 00             	movzbl (%eax),%eax
80100679:	31 db                	xor    %ebx,%ebx
8010067b:	89 cf                	mov    %ecx,%edi
8010067d:	8d 75 0c             	lea    0xc(%ebp),%esi
80100680:	85 c0                	test   %eax,%eax
80100682:	75 4c                	jne    801006d0 <cprintf+0x80>
80100684:	eb 5f                	jmp    801006e5 <cprintf+0x95>
80100686:	66 90                	xchg   %ax,%ax
    c = fmt[++i] & 0xff;
80100688:	83 c3 01             	add    $0x1,%ebx
8010068b:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
8010068f:	85 d2                	test   %edx,%edx
80100691:	74 52                	je     801006e5 <cprintf+0x95>
    switch(c){
80100693:	83 fa 70             	cmp    $0x70,%edx
80100696:	74 72                	je     8010070a <cprintf+0xba>
80100698:	7f 66                	jg     80100700 <cprintf+0xb0>
8010069a:	83 fa 25             	cmp    $0x25,%edx
8010069d:	8d 76 00             	lea    0x0(%esi),%esi
801006a0:	0f 84 a2 00 00 00    	je     80100748 <cprintf+0xf8>
801006a6:	83 fa 64             	cmp    $0x64,%edx
801006a9:	75 7d                	jne    80100728 <cprintf+0xd8>
      printint(*argp++, 10, 1);
801006ab:	8d 46 04             	lea    0x4(%esi),%eax
801006ae:	b9 01 00 00 00       	mov    $0x1,%ecx
801006b3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006b6:	8b 06                	mov    (%esi),%eax
801006b8:	ba 0a 00 00 00       	mov    $0xa,%edx
801006bd:	e8 ae fe ff ff       	call   80100570 <printint>
801006c2:	8b 75 e4             	mov    -0x1c(%ebp),%esi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006c5:	83 c3 01             	add    $0x1,%ebx
801006c8:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006cc:	85 c0                	test   %eax,%eax
801006ce:	74 15                	je     801006e5 <cprintf+0x95>
    if(c != '%'){
801006d0:	83 f8 25             	cmp    $0x25,%eax
801006d3:	74 b3                	je     80100688 <cprintf+0x38>
      consputc(c);
801006d5:	e8 06 fd ff ff       	call   801003e0 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006da:	83 c3 01             	add    $0x1,%ebx
801006dd:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006e1:	85 c0                	test   %eax,%eax
801006e3:	75 eb                	jne    801006d0 <cprintf+0x80>
  if(locking)
801006e5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801006e8:	85 c0                	test   %eax,%eax
801006ea:	74 0c                	je     801006f8 <cprintf+0xa8>
    release(&cons.lock);
801006ec:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801006f3:	e8 48 3e 00 00       	call   80104540 <release>
}
801006f8:	83 c4 1c             	add    $0x1c,%esp
801006fb:	5b                   	pop    %ebx
801006fc:	5e                   	pop    %esi
801006fd:	5f                   	pop    %edi
801006fe:	5d                   	pop    %ebp
801006ff:	c3                   	ret    
    switch(c){
80100700:	83 fa 73             	cmp    $0x73,%edx
80100703:	74 53                	je     80100758 <cprintf+0x108>
80100705:	83 fa 78             	cmp    $0x78,%edx
80100708:	75 1e                	jne    80100728 <cprintf+0xd8>
      printint(*argp++, 16, 0);
8010070a:	8d 46 04             	lea    0x4(%esi),%eax
8010070d:	31 c9                	xor    %ecx,%ecx
8010070f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100712:	8b 06                	mov    (%esi),%eax
80100714:	ba 10 00 00 00       	mov    $0x10,%edx
80100719:	e8 52 fe ff ff       	call   80100570 <printint>
8010071e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100721:	eb a2                	jmp    801006c5 <cprintf+0x75>
80100723:	90                   	nop
80100724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100728:	b8 25 00 00 00       	mov    $0x25,%eax
8010072d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100730:	e8 ab fc ff ff       	call   801003e0 <consputc>
      consputc(c);
80100735:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100738:	89 d0                	mov    %edx,%eax
8010073a:	e8 a1 fc ff ff       	call   801003e0 <consputc>
8010073f:	eb 99                	jmp    801006da <cprintf+0x8a>
80100741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	e8 8e fc ff ff       	call   801003e0 <consputc>
      break;
80100752:	e9 6e ff ff ff       	jmp    801006c5 <cprintf+0x75>
80100757:	90                   	nop
      if((s = (char*)*argp++) == 0)
80100758:	8d 46 04             	lea    0x4(%esi),%eax
8010075b:	8b 36                	mov    (%esi),%esi
8010075d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100760:	b8 78 70 10 80       	mov    $0x80107078,%eax
80100765:	85 f6                	test   %esi,%esi
80100767:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
8010076a:	0f be 06             	movsbl (%esi),%eax
8010076d:	84 c0                	test   %al,%al
8010076f:	74 16                	je     80100787 <cprintf+0x137>
80100771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100778:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
8010077b:	e8 60 fc ff ff       	call   801003e0 <consputc>
      for(; *s; s++)
80100780:	0f be 06             	movsbl (%esi),%eax
80100783:	84 c0                	test   %al,%al
80100785:	75 f1                	jne    80100778 <cprintf+0x128>
      if((s = (char*)*argp++) == 0)
80100787:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010078a:	e9 36 ff ff ff       	jmp    801006c5 <cprintf+0x75>
8010078f:	90                   	nop
    acquire(&cons.lock);
80100790:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100797:	e8 34 3d 00 00       	call   801044d0 <acquire>
8010079c:	e9 c8 fe ff ff       	jmp    80100669 <cprintf+0x19>
    panic("null fmt");
801007a1:	c7 04 24 7f 70 10 80 	movl   $0x8010707f,(%esp)
801007a8:	e8 b3 fb ff ff       	call   80100360 <panic>
801007ad:	8d 76 00             	lea    0x0(%esi),%esi

801007b0 <consoleintr>:
{
801007b0:	55                   	push   %ebp
801007b1:	89 e5                	mov    %esp,%ebp
801007b3:	57                   	push   %edi
801007b4:	56                   	push   %esi
  int c, doprocdump = 0;
801007b5:	31 f6                	xor    %esi,%esi
{
801007b7:	53                   	push   %ebx
801007b8:	83 ec 1c             	sub    $0x1c,%esp
801007bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801007be:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801007c5:	e8 06 3d 00 00       	call   801044d0 <acquire>
801007ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while((c = getc()) >= 0){
801007d0:	ff d3                	call   *%ebx
801007d2:	85 c0                	test   %eax,%eax
801007d4:	89 c7                	mov    %eax,%edi
801007d6:	78 48                	js     80100820 <consoleintr+0x70>
    switch(c){
801007d8:	83 ff 10             	cmp    $0x10,%edi
801007db:	0f 84 2f 01 00 00    	je     80100910 <consoleintr+0x160>
801007e1:	7e 5d                	jle    80100840 <consoleintr+0x90>
801007e3:	83 ff 15             	cmp    $0x15,%edi
801007e6:	0f 84 d4 00 00 00    	je     801008c0 <consoleintr+0x110>
801007ec:	83 ff 7f             	cmp    $0x7f,%edi
801007ef:	90                   	nop
801007f0:	75 53                	jne    80100845 <consoleintr+0x95>
      if(input.e != input.w){
801007f2:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801007f7:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801007fd:	74 d1                	je     801007d0 <consoleintr+0x20>
        input.e--;
801007ff:	83 e8 01             	sub    $0x1,%eax
80100802:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
80100807:	b8 00 01 00 00       	mov    $0x100,%eax
8010080c:	e8 cf fb ff ff       	call   801003e0 <consputc>
  while((c = getc()) >= 0){
80100811:	ff d3                	call   *%ebx
80100813:	85 c0                	test   %eax,%eax
80100815:	89 c7                	mov    %eax,%edi
80100817:	79 bf                	jns    801007d8 <consoleintr+0x28>
80100819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100820:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100827:	e8 14 3d 00 00       	call   80104540 <release>
  if(doprocdump) {
8010082c:	85 f6                	test   %esi,%esi
8010082e:	0f 85 ec 00 00 00    	jne    80100920 <consoleintr+0x170>
}
80100834:	83 c4 1c             	add    $0x1c,%esp
80100837:	5b                   	pop    %ebx
80100838:	5e                   	pop    %esi
80100839:	5f                   	pop    %edi
8010083a:	5d                   	pop    %ebp
8010083b:	c3                   	ret    
8010083c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100840:	83 ff 08             	cmp    $0x8,%edi
80100843:	74 ad                	je     801007f2 <consoleintr+0x42>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100845:	85 ff                	test   %edi,%edi
80100847:	74 87                	je     801007d0 <consoleintr+0x20>
80100849:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010084e:	89 c2                	mov    %eax,%edx
80100850:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
80100856:	83 fa 7f             	cmp    $0x7f,%edx
80100859:	0f 87 71 ff ff ff    	ja     801007d0 <consoleintr+0x20>
        input.buf[input.e++ % INPUT_BUF] = c;
8010085f:	8d 50 01             	lea    0x1(%eax),%edx
80100862:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100865:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100868:	89 15 a8 ff 10 80    	mov    %edx,0x8010ffa8
        c = (c == '\r') ? '\n' : c;
8010086e:	0f 84 b8 00 00 00    	je     8010092c <consoleintr+0x17c>
        input.buf[input.e++ % INPUT_BUF] = c;
80100874:	89 f9                	mov    %edi,%ecx
80100876:	88 88 20 ff 10 80    	mov    %cl,-0x7fef00e0(%eax)
        consputc(c);
8010087c:	89 f8                	mov    %edi,%eax
8010087e:	e8 5d fb ff ff       	call   801003e0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100883:	83 ff 04             	cmp    $0x4,%edi
80100886:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010088b:	74 19                	je     801008a6 <consoleintr+0xf6>
8010088d:	83 ff 0a             	cmp    $0xa,%edi
80100890:	74 14                	je     801008a6 <consoleintr+0xf6>
80100892:	8b 0d a0 ff 10 80    	mov    0x8010ffa0,%ecx
80100898:	8d 91 80 00 00 00    	lea    0x80(%ecx),%edx
8010089e:	39 d0                	cmp    %edx,%eax
801008a0:	0f 85 2a ff ff ff    	jne    801007d0 <consoleintr+0x20>
          wakeup(&input.r);
801008a6:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
          input.w = input.e;
801008ad:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
801008b2:	e8 99 37 00 00       	call   80104050 <wakeup>
801008b7:	e9 14 ff ff ff       	jmp    801007d0 <consoleintr+0x20>
801008bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
801008c0:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008c5:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801008cb:	75 2b                	jne    801008f8 <consoleintr+0x148>
801008cd:	e9 fe fe ff ff       	jmp    801007d0 <consoleintr+0x20>
801008d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
801008d8:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
801008dd:	b8 00 01 00 00       	mov    $0x100,%eax
801008e2:	e8 f9 fa ff ff       	call   801003e0 <consputc>
      while(input.e != input.w &&
801008e7:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008ec:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801008f2:	0f 84 d8 fe ff ff    	je     801007d0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008f8:	83 e8 01             	sub    $0x1,%eax
801008fb:	89 c2                	mov    %eax,%edx
801008fd:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100900:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
80100907:	75 cf                	jne    801008d8 <consoleintr+0x128>
80100909:	e9 c2 fe ff ff       	jmp    801007d0 <consoleintr+0x20>
8010090e:	66 90                	xchg   %ax,%ax
      doprocdump = 1;
80100910:	be 01 00 00 00       	mov    $0x1,%esi
80100915:	e9 b6 fe ff ff       	jmp    801007d0 <consoleintr+0x20>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80100920:	83 c4 1c             	add    $0x1c,%esp
80100923:	5b                   	pop    %ebx
80100924:	5e                   	pop    %esi
80100925:	5f                   	pop    %edi
80100926:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100927:	e9 14 38 00 00       	jmp    80104140 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
8010092c:	c6 80 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%eax)
        consputc(c);
80100933:	b8 0a 00 00 00       	mov    $0xa,%eax
80100938:	e8 a3 fa ff ff       	call   801003e0 <consputc>
8010093d:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100942:	e9 5f ff ff ff       	jmp    801008a6 <consoleintr+0xf6>
80100947:	89 f6                	mov    %esi,%esi
80100949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100950 <consoleinit>:

void
consoleinit(void)
{
80100950:	55                   	push   %ebp
80100951:	89 e5                	mov    %esp,%ebp
80100953:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100956:	c7 44 24 04 88 70 10 	movl   $0x80107088,0x4(%esp)
8010095d:	80 
8010095e:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100965:	e8 f6 39 00 00       	call   80104360 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
8010096a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100971:	00 
80100972:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
80100979:	c7 05 6c 09 11 80 f0 	movl   $0x801005f0,0x8011096c
80100980:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100983:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
8010098a:	02 10 80 
  cons.locking = 1;
8010098d:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
80100994:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100997:	e8 14 19 00 00       	call   801022b0 <ioapicenable>
}
8010099c:	c9                   	leave  
8010099d:	c3                   	ret    
8010099e:	66 90                	xchg   %ax,%ax

801009a0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009a0:	55                   	push   %ebp
801009a1:	89 e5                	mov    %esp,%ebp
801009a3:	57                   	push   %edi
801009a4:	56                   	push   %esi
801009a5:	53                   	push   %ebx
801009a6:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009ac:	e8 3f 2d 00 00       	call   801036f0 <myproc>
801009b1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
801009b7:	e8 54 21 00 00       	call   80102b10 <begin_op>

  if((ip = namei(path)) == 0){
801009bc:	8b 45 08             	mov    0x8(%ebp),%eax
801009bf:	89 04 24             	mov    %eax,(%esp)
801009c2:	e8 39 15 00 00       	call   80101f00 <namei>
801009c7:	85 c0                	test   %eax,%eax
801009c9:	89 c3                	mov    %eax,%ebx
801009cb:	0f 84 c2 01 00 00    	je     80100b93 <exec+0x1f3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801009d1:	89 04 24             	mov    %eax,(%esp)
801009d4:	e8 d7 0c 00 00       	call   801016b0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
801009d9:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
801009df:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
801009e6:	00 
801009e7:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
801009ee:	00 
801009ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801009f3:	89 1c 24             	mov    %ebx,(%esp)
801009f6:	e8 65 0f 00 00       	call   80101960 <readi>
801009fb:	83 f8 34             	cmp    $0x34,%eax
801009fe:	74 20                	je     80100a20 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a00:	89 1c 24             	mov    %ebx,(%esp)
80100a03:	e8 08 0f 00 00       	call   80101910 <iunlockput>
    end_op();
80100a08:	e8 73 21 00 00       	call   80102b80 <end_op>
  }
  return -1;
80100a0d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a12:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100a18:	5b                   	pop    %ebx
80100a19:	5e                   	pop    %esi
80100a1a:	5f                   	pop    %edi
80100a1b:	5d                   	pop    %ebp
80100a1c:	c3                   	ret    
80100a1d:	8d 76 00             	lea    0x0(%esi),%esi
  if(elf.magic != ELF_MAGIC)
80100a20:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a27:	45 4c 46 
80100a2a:	75 d4                	jne    80100a00 <exec+0x60>
  if((pgdir = setupkvm()) == 0)
80100a2c:	e8 3f 63 00 00       	call   80106d70 <setupkvm>
80100a31:	85 c0                	test   %eax,%eax
80100a33:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a39:	74 c5                	je     80100a00 <exec+0x60>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a3b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a42:	00 
80100a43:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
  sz = 0;
80100a49:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100a50:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a53:	0f 84 da 00 00 00    	je     80100b33 <exec+0x193>
80100a59:	31 ff                	xor    %edi,%edi
80100a5b:	eb 18                	jmp    80100a75 <exec+0xd5>
80100a5d:	8d 76 00             	lea    0x0(%esi),%esi
80100a60:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100a67:	83 c7 01             	add    $0x1,%edi
80100a6a:	83 c6 20             	add    $0x20,%esi
80100a6d:	39 f8                	cmp    %edi,%eax
80100a6f:	0f 8e be 00 00 00    	jle    80100b33 <exec+0x193>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100a75:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100a7b:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100a82:	00 
80100a83:	89 74 24 08          	mov    %esi,0x8(%esp)
80100a87:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a8b:	89 1c 24             	mov    %ebx,(%esp)
80100a8e:	e8 cd 0e 00 00       	call   80101960 <readi>
80100a93:	83 f8 20             	cmp    $0x20,%eax
80100a96:	0f 85 84 00 00 00    	jne    80100b20 <exec+0x180>
    if(ph.type != ELF_PROG_LOAD)
80100a9c:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100aa3:	75 bb                	jne    80100a60 <exec+0xc0>
    if(ph.memsz < ph.filesz)
80100aa5:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100aab:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ab1:	72 6d                	jb     80100b20 <exec+0x180>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100ab3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ab9:	72 65                	jb     80100b20 <exec+0x180>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100abb:	89 44 24 08          	mov    %eax,0x8(%esp)
80100abf:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100ac5:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ac9:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100acf:	89 04 24             	mov    %eax,(%esp)
80100ad2:	e8 09 61 00 00       	call   80106be0 <allocuvm>
80100ad7:	85 c0                	test   %eax,%eax
80100ad9:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100adf:	74 3f                	je     80100b20 <exec+0x180>
    if(ph.vaddr % PGSIZE != 0)
80100ae1:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100ae7:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100aec:	75 32                	jne    80100b20 <exec+0x180>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100aee:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100af4:	89 44 24 04          	mov    %eax,0x4(%esp)
80100af8:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100afe:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100b02:	89 54 24 10          	mov    %edx,0x10(%esp)
80100b06:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100b0c:	89 04 24             	mov    %eax,(%esp)
80100b0f:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100b13:	e8 08 60 00 00       	call   80106b20 <loaduvm>
80100b18:	85 c0                	test   %eax,%eax
80100b1a:	0f 89 40 ff ff ff    	jns    80100a60 <exec+0xc0>
    freevm(pgdir);
80100b20:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b26:	89 04 24             	mov    %eax,(%esp)
80100b29:	e8 c2 61 00 00       	call   80106cf0 <freevm>
80100b2e:	e9 cd fe ff ff       	jmp    80100a00 <exec+0x60>
  iunlockput(ip);
80100b33:	89 1c 24             	mov    %ebx,(%esp)
80100b36:	e8 d5 0d 00 00       	call   80101910 <iunlockput>
80100b3b:	90                   	nop
80100b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  end_op();
80100b40:	e8 3b 20 00 00       	call   80102b80 <end_op>
  sz = PGROUNDUP(sz);
80100b45:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100b4b:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b50:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b55:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b5b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b5f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b65:	89 54 24 08          	mov    %edx,0x8(%esp)
80100b69:	89 04 24             	mov    %eax,(%esp)
80100b6c:	e8 6f 60 00 00       	call   80106be0 <allocuvm>
80100b71:	85 c0                	test   %eax,%eax
80100b73:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
80100b79:	75 33                	jne    80100bae <exec+0x20e>
    freevm(pgdir);
80100b7b:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b81:	89 04 24             	mov    %eax,(%esp)
80100b84:	e8 67 61 00 00       	call   80106cf0 <freevm>
  return -1;
80100b89:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b8e:	e9 7f fe ff ff       	jmp    80100a12 <exec+0x72>
    end_op();
80100b93:	e8 e8 1f 00 00       	call   80102b80 <end_op>
    cprintf("exec: fail\n");
80100b98:	c7 04 24 a1 70 10 80 	movl   $0x801070a1,(%esp)
80100b9f:	e8 ac fa ff ff       	call   80100650 <cprintf>
    return -1;
80100ba4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ba9:	e9 64 fe ff ff       	jmp    80100a12 <exec+0x72>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bae:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100bb4:	89 d8                	mov    %ebx,%eax
80100bb6:	2d 00 20 00 00       	sub    $0x2000,%eax
80100bbb:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bbf:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100bc5:	89 04 24             	mov    %eax,(%esp)
80100bc8:	e8 53 62 00 00       	call   80106e20 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100bcd:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bd0:	8b 00                	mov    (%eax),%eax
80100bd2:	85 c0                	test   %eax,%eax
80100bd4:	0f 84 59 01 00 00    	je     80100d33 <exec+0x393>
80100bda:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100bdd:	31 d2                	xor    %edx,%edx
80100bdf:	8d 71 04             	lea    0x4(%ecx),%esi
80100be2:	89 cf                	mov    %ecx,%edi
80100be4:	89 d1                	mov    %edx,%ecx
80100be6:	89 f2                	mov    %esi,%edx
80100be8:	89 fe                	mov    %edi,%esi
80100bea:	89 cf                	mov    %ecx,%edi
80100bec:	eb 0a                	jmp    80100bf8 <exec+0x258>
80100bee:	66 90                	xchg   %ax,%ax
80100bf0:	83 c2 04             	add    $0x4,%edx
    if(argc >= MAXARG)
80100bf3:	83 ff 20             	cmp    $0x20,%edi
80100bf6:	74 83                	je     80100b7b <exec+0x1db>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100bf8:	89 04 24             	mov    %eax,(%esp)
80100bfb:	89 95 ec fe ff ff    	mov    %edx,-0x114(%ebp)
80100c01:	e8 aa 3b 00 00       	call   801047b0 <strlen>
80100c06:	f7 d0                	not    %eax
80100c08:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c0a:	8b 06                	mov    (%esi),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c0c:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c0f:	89 04 24             	mov    %eax,(%esp)
80100c12:	e8 99 3b 00 00       	call   801047b0 <strlen>
80100c17:	83 c0 01             	add    $0x1,%eax
80100c1a:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c1e:	8b 06                	mov    (%esi),%eax
80100c20:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c24:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c28:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c2e:	89 04 24             	mov    %eax,(%esp)
80100c31:	e8 4a 63 00 00       	call   80106f80 <copyout>
80100c36:	85 c0                	test   %eax,%eax
80100c38:	0f 88 3d ff ff ff    	js     80100b7b <exec+0x1db>
  for(argc = 0; argv[argc]; argc++) {
80100c3e:	8b 95 ec fe ff ff    	mov    -0x114(%ebp),%edx
    ustack[3+argc] = sp;
80100c44:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100c4a:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c51:	83 c7 01             	add    $0x1,%edi
80100c54:	8b 02                	mov    (%edx),%eax
80100c56:	89 d6                	mov    %edx,%esi
80100c58:	85 c0                	test   %eax,%eax
80100c5a:	75 94                	jne    80100bf0 <exec+0x250>
80100c5c:	89 fa                	mov    %edi,%edx
  ustack[3+argc] = 0;
80100c5e:	c7 84 95 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edx,4)
80100c65:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c69:	8d 04 95 04 00 00 00 	lea    0x4(,%edx,4),%eax
  ustack[1] = argc;
80100c70:	89 95 5c ff ff ff    	mov    %edx,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c76:	89 da                	mov    %ebx,%edx
80100c78:	29 c2                	sub    %eax,%edx
  sp -= (3+argc+1) * 4;
80100c7a:	83 c0 0c             	add    $0xc,%eax
80100c7d:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c7f:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c83:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c89:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80100c8d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  ustack[0] = 0xffffffff;  // fake return PC
80100c91:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c98:	ff ff ff 
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c9b:	89 04 24             	mov    %eax,(%esp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c9e:	89 95 60 ff ff ff    	mov    %edx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100ca4:	e8 d7 62 00 00       	call   80106f80 <copyout>
80100ca9:	85 c0                	test   %eax,%eax
80100cab:	0f 88 ca fe ff ff    	js     80100b7b <exec+0x1db>
  for(last=s=path; *s; s++)
80100cb1:	8b 45 08             	mov    0x8(%ebp),%eax
80100cb4:	0f b6 10             	movzbl (%eax),%edx
80100cb7:	84 d2                	test   %dl,%dl
80100cb9:	74 19                	je     80100cd4 <exec+0x334>
80100cbb:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cbe:	83 c0 01             	add    $0x1,%eax
      last = s+1;
80100cc1:	80 fa 2f             	cmp    $0x2f,%dl
  for(last=s=path; *s; s++)
80100cc4:	0f b6 10             	movzbl (%eax),%edx
      last = s+1;
80100cc7:	0f 44 c8             	cmove  %eax,%ecx
80100cca:	83 c0 01             	add    $0x1,%eax
  for(last=s=path; *s; s++)
80100ccd:	84 d2                	test   %dl,%dl
80100ccf:	75 f0                	jne    80100cc1 <exec+0x321>
80100cd1:	89 4d 08             	mov    %ecx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cd4:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cda:	8b 45 08             	mov    0x8(%ebp),%eax
80100cdd:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100ce4:	00 
80100ce5:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ce9:	89 f8                	mov    %edi,%eax
80100ceb:	83 c0 6c             	add    $0x6c,%eax
80100cee:	89 04 24             	mov    %eax,(%esp)
80100cf1:	e8 7a 3a 00 00       	call   80104770 <safestrcpy>
  curproc->pgdir = pgdir;
80100cf6:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100cfc:	8b 77 04             	mov    0x4(%edi),%esi
  curproc->tf->eip = elf.entry;  // main
80100cff:	8b 47 18             	mov    0x18(%edi),%eax
  curproc->pgdir = pgdir;
80100d02:	89 4f 04             	mov    %ecx,0x4(%edi)
  curproc->sz = sz;
80100d05:	8b 8d e8 fe ff ff    	mov    -0x118(%ebp),%ecx
80100d0b:	89 0f                	mov    %ecx,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100d0d:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d13:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d16:	8b 47 18             	mov    0x18(%edi),%eax
80100d19:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d1c:	89 3c 24             	mov    %edi,(%esp)
80100d1f:	e8 6c 5c 00 00       	call   80106990 <switchuvm>
  freevm(oldpgdir);
80100d24:	89 34 24             	mov    %esi,(%esp)
80100d27:	e8 c4 5f 00 00       	call   80106cf0 <freevm>
  return 0;
80100d2c:	31 c0                	xor    %eax,%eax
80100d2e:	e9 df fc ff ff       	jmp    80100a12 <exec+0x72>
  for(argc = 0; argv[argc]; argc++) {
80100d33:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100d39:	31 d2                	xor    %edx,%edx
80100d3b:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100d41:	e9 18 ff ff ff       	jmp    80100c5e <exec+0x2be>
80100d46:	66 90                	xchg   %ax,%ax
80100d48:	66 90                	xchg   %ax,%ax
80100d4a:	66 90                	xchg   %ax,%ax
80100d4c:	66 90                	xchg   %ax,%ax
80100d4e:	66 90                	xchg   %ax,%ax

80100d50 <fileinit>:
80100d50:	55                   	push   %ebp
80100d51:	89 e5                	mov    %esp,%ebp
80100d53:	83 ec 18             	sub    $0x18,%esp
80100d56:	c7 44 24 04 ad 70 10 	movl   $0x801070ad,0x4(%esp)
80100d5d:	80 
80100d5e:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d65:	e8 f6 35 00 00       	call   80104360 <initlock>
80100d6a:	c9                   	leave  
80100d6b:	c3                   	ret    
80100d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100d70 <filealloc>:
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	53                   	push   %ebx
80100d74:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
80100d79:	83 ec 14             	sub    $0x14,%esp
80100d7c:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d83:	e8 48 37 00 00       	call   801044d0 <acquire>
80100d88:	eb 11                	jmp    80100d9b <filealloc+0x2b>
80100d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100d90:	83 c3 18             	add    $0x18,%ebx
80100d93:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100d99:	74 25                	je     80100dc0 <filealloc+0x50>
80100d9b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d9e:	85 c0                	test   %eax,%eax
80100da0:	75 ee                	jne    80100d90 <filealloc+0x20>
80100da2:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100da9:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
80100db0:	e8 8b 37 00 00       	call   80104540 <release>
80100db5:	83 c4 14             	add    $0x14,%esp
80100db8:	89 d8                	mov    %ebx,%eax
80100dba:	5b                   	pop    %ebx
80100dbb:	5d                   	pop    %ebp
80100dbc:	c3                   	ret    
80100dbd:	8d 76 00             	lea    0x0(%esi),%esi
80100dc0:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100dc7:	e8 74 37 00 00       	call   80104540 <release>
80100dcc:	83 c4 14             	add    $0x14,%esp
80100dcf:	31 c0                	xor    %eax,%eax
80100dd1:	5b                   	pop    %ebx
80100dd2:	5d                   	pop    %ebp
80100dd3:	c3                   	ret    
80100dd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100dda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100de0 <filedup>:
80100de0:	55                   	push   %ebp
80100de1:	89 e5                	mov    %esp,%ebp
80100de3:	53                   	push   %ebx
80100de4:	83 ec 14             	sub    $0x14,%esp
80100de7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100dea:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100df1:	e8 da 36 00 00       	call   801044d0 <acquire>
80100df6:	8b 43 04             	mov    0x4(%ebx),%eax
80100df9:	85 c0                	test   %eax,%eax
80100dfb:	7e 1a                	jle    80100e17 <filedup+0x37>
80100dfd:	83 c0 01             	add    $0x1,%eax
80100e00:	89 43 04             	mov    %eax,0x4(%ebx)
80100e03:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100e0a:	e8 31 37 00 00       	call   80104540 <release>
80100e0f:	83 c4 14             	add    $0x14,%esp
80100e12:	89 d8                	mov    %ebx,%eax
80100e14:	5b                   	pop    %ebx
80100e15:	5d                   	pop    %ebp
80100e16:	c3                   	ret    
80100e17:	c7 04 24 b4 70 10 80 	movl   $0x801070b4,(%esp)
80100e1e:	e8 3d f5 ff ff       	call   80100360 <panic>
80100e23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e30 <fileclose>:
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	57                   	push   %edi
80100e34:	56                   	push   %esi
80100e35:	53                   	push   %ebx
80100e36:	83 ec 1c             	sub    $0x1c,%esp
80100e39:	8b 7d 08             	mov    0x8(%ebp),%edi
80100e3c:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100e43:	e8 88 36 00 00       	call   801044d0 <acquire>
80100e48:	8b 57 04             	mov    0x4(%edi),%edx
80100e4b:	85 d2                	test   %edx,%edx
80100e4d:	0f 8e 89 00 00 00    	jle    80100edc <fileclose+0xac>
80100e53:	83 ea 01             	sub    $0x1,%edx
80100e56:	85 d2                	test   %edx,%edx
80100e58:	89 57 04             	mov    %edx,0x4(%edi)
80100e5b:	74 13                	je     80100e70 <fileclose+0x40>
80100e5d:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
80100e64:	83 c4 1c             	add    $0x1c,%esp
80100e67:	5b                   	pop    %ebx
80100e68:	5e                   	pop    %esi
80100e69:	5f                   	pop    %edi
80100e6a:	5d                   	pop    %ebp
80100e6b:	e9 d0 36 00 00       	jmp    80104540 <release>
80100e70:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e74:	8b 37                	mov    (%edi),%esi
80100e76:	8b 5f 0c             	mov    0xc(%edi),%ebx
80100e79:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80100e7f:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e82:	8b 47 10             	mov    0x10(%edi),%eax
80100e85:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100e8c:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100e8f:	e8 ac 36 00 00       	call   80104540 <release>
80100e94:	83 fe 01             	cmp    $0x1,%esi
80100e97:	74 0f                	je     80100ea8 <fileclose+0x78>
80100e99:	83 fe 02             	cmp    $0x2,%esi
80100e9c:	74 22                	je     80100ec0 <fileclose+0x90>
80100e9e:	83 c4 1c             	add    $0x1c,%esp
80100ea1:	5b                   	pop    %ebx
80100ea2:	5e                   	pop    %esi
80100ea3:	5f                   	pop    %edi
80100ea4:	5d                   	pop    %ebp
80100ea5:	c3                   	ret    
80100ea6:	66 90                	xchg   %ax,%ax
80100ea8:	0f be 75 e7          	movsbl -0x19(%ebp),%esi
80100eac:	89 1c 24             	mov    %ebx,(%esp)
80100eaf:	89 74 24 04          	mov    %esi,0x4(%esp)
80100eb3:	e8 a8 23 00 00       	call   80103260 <pipeclose>
80100eb8:	eb e4                	jmp    80100e9e <fileclose+0x6e>
80100eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100ec0:	e8 4b 1c 00 00       	call   80102b10 <begin_op>
80100ec5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ec8:	89 04 24             	mov    %eax,(%esp)
80100ecb:	e8 00 09 00 00       	call   801017d0 <iput>
80100ed0:	83 c4 1c             	add    $0x1c,%esp
80100ed3:	5b                   	pop    %ebx
80100ed4:	5e                   	pop    %esi
80100ed5:	5f                   	pop    %edi
80100ed6:	5d                   	pop    %ebp
80100ed7:	e9 a4 1c 00 00       	jmp    80102b80 <end_op>
80100edc:	c7 04 24 bc 70 10 80 	movl   $0x801070bc,(%esp)
80100ee3:	e8 78 f4 ff ff       	call   80100360 <panic>
80100ee8:	90                   	nop
80100ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ef0 <filestat>:
80100ef0:	55                   	push   %ebp
80100ef1:	89 e5                	mov    %esp,%ebp
80100ef3:	53                   	push   %ebx
80100ef4:	83 ec 14             	sub    $0x14,%esp
80100ef7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100efa:	83 3b 02             	cmpl   $0x2,(%ebx)
80100efd:	75 31                	jne    80100f30 <filestat+0x40>
80100eff:	8b 43 10             	mov    0x10(%ebx),%eax
80100f02:	89 04 24             	mov    %eax,(%esp)
80100f05:	e8 a6 07 00 00       	call   801016b0 <ilock>
80100f0a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f0d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100f11:	8b 43 10             	mov    0x10(%ebx),%eax
80100f14:	89 04 24             	mov    %eax,(%esp)
80100f17:	e8 14 0a 00 00       	call   80101930 <stati>
80100f1c:	8b 43 10             	mov    0x10(%ebx),%eax
80100f1f:	89 04 24             	mov    %eax,(%esp)
80100f22:	e8 69 08 00 00       	call   80101790 <iunlock>
80100f27:	83 c4 14             	add    $0x14,%esp
80100f2a:	31 c0                	xor    %eax,%eax
80100f2c:	5b                   	pop    %ebx
80100f2d:	5d                   	pop    %ebp
80100f2e:	c3                   	ret    
80100f2f:	90                   	nop
80100f30:	83 c4 14             	add    $0x14,%esp
80100f33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f38:	5b                   	pop    %ebx
80100f39:	5d                   	pop    %ebp
80100f3a:	c3                   	ret    
80100f3b:	90                   	nop
80100f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f40 <fileread>:
80100f40:	55                   	push   %ebp
80100f41:	89 e5                	mov    %esp,%ebp
80100f43:	57                   	push   %edi
80100f44:	56                   	push   %esi
80100f45:	53                   	push   %ebx
80100f46:	83 ec 1c             	sub    $0x1c,%esp
80100f49:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f4c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f4f:	8b 7d 10             	mov    0x10(%ebp),%edi
80100f52:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f56:	74 68                	je     80100fc0 <fileread+0x80>
80100f58:	8b 03                	mov    (%ebx),%eax
80100f5a:	83 f8 01             	cmp    $0x1,%eax
80100f5d:	74 49                	je     80100fa8 <fileread+0x68>
80100f5f:	83 f8 02             	cmp    $0x2,%eax
80100f62:	75 63                	jne    80100fc7 <fileread+0x87>
80100f64:	8b 43 10             	mov    0x10(%ebx),%eax
80100f67:	89 04 24             	mov    %eax,(%esp)
80100f6a:	e8 41 07 00 00       	call   801016b0 <ilock>
80100f6f:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100f73:	8b 43 14             	mov    0x14(%ebx),%eax
80100f76:	89 74 24 04          	mov    %esi,0x4(%esp)
80100f7a:	89 44 24 08          	mov    %eax,0x8(%esp)
80100f7e:	8b 43 10             	mov    0x10(%ebx),%eax
80100f81:	89 04 24             	mov    %eax,(%esp)
80100f84:	e8 d7 09 00 00       	call   80101960 <readi>
80100f89:	85 c0                	test   %eax,%eax
80100f8b:	89 c6                	mov    %eax,%esi
80100f8d:	7e 03                	jle    80100f92 <fileread+0x52>
80100f8f:	01 43 14             	add    %eax,0x14(%ebx)
80100f92:	8b 43 10             	mov    0x10(%ebx),%eax
80100f95:	89 04 24             	mov    %eax,(%esp)
80100f98:	e8 f3 07 00 00       	call   80101790 <iunlock>
80100f9d:	89 f0                	mov    %esi,%eax
80100f9f:	83 c4 1c             	add    $0x1c,%esp
80100fa2:	5b                   	pop    %ebx
80100fa3:	5e                   	pop    %esi
80100fa4:	5f                   	pop    %edi
80100fa5:	5d                   	pop    %ebp
80100fa6:	c3                   	ret    
80100fa7:	90                   	nop
80100fa8:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fab:	89 45 08             	mov    %eax,0x8(%ebp)
80100fae:	83 c4 1c             	add    $0x1c,%esp
80100fb1:	5b                   	pop    %ebx
80100fb2:	5e                   	pop    %esi
80100fb3:	5f                   	pop    %edi
80100fb4:	5d                   	pop    %ebp
80100fb5:	e9 26 24 00 00       	jmp    801033e0 <piperead>
80100fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100fc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fc5:	eb d8                	jmp    80100f9f <fileread+0x5f>
80100fc7:	c7 04 24 c6 70 10 80 	movl   $0x801070c6,(%esp)
80100fce:	e8 8d f3 ff ff       	call   80100360 <panic>
80100fd3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100fe0 <filewrite>:
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	57                   	push   %edi
80100fe4:	56                   	push   %esi
80100fe5:	53                   	push   %ebx
80100fe6:	83 ec 2c             	sub    $0x2c,%esp
80100fe9:	8b 45 0c             	mov    0xc(%ebp),%eax
80100fec:	8b 7d 08             	mov    0x8(%ebp),%edi
80100fef:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100ff2:	8b 45 10             	mov    0x10(%ebp),%eax
80100ff5:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)
80100ff9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100ffc:	0f 84 ae 00 00 00    	je     801010b0 <filewrite+0xd0>
80101002:	8b 07                	mov    (%edi),%eax
80101004:	83 f8 01             	cmp    $0x1,%eax
80101007:	0f 84 c2 00 00 00    	je     801010cf <filewrite+0xef>
8010100d:	83 f8 02             	cmp    $0x2,%eax
80101010:	0f 85 d7 00 00 00    	jne    801010ed <filewrite+0x10d>
80101016:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101019:	31 db                	xor    %ebx,%ebx
8010101b:	85 c0                	test   %eax,%eax
8010101d:	7f 31                	jg     80101050 <filewrite+0x70>
8010101f:	e9 9c 00 00 00       	jmp    801010c0 <filewrite+0xe0>
80101024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101028:	8b 4f 10             	mov    0x10(%edi),%ecx
8010102b:	01 47 14             	add    %eax,0x14(%edi)
8010102e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101031:	89 0c 24             	mov    %ecx,(%esp)
80101034:	e8 57 07 00 00       	call   80101790 <iunlock>
80101039:	e8 42 1b 00 00       	call   80102b80 <end_op>
8010103e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101041:	39 f0                	cmp    %esi,%eax
80101043:	0f 85 98 00 00 00    	jne    801010e1 <filewrite+0x101>
80101049:	01 c3                	add    %eax,%ebx
8010104b:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
8010104e:	7e 70                	jle    801010c0 <filewrite+0xe0>
80101050:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101053:	b8 00 06 00 00       	mov    $0x600,%eax
80101058:	29 de                	sub    %ebx,%esi
8010105a:	81 fe 00 06 00 00    	cmp    $0x600,%esi
80101060:	0f 4f f0             	cmovg  %eax,%esi
80101063:	e8 a8 1a 00 00       	call   80102b10 <begin_op>
80101068:	8b 47 10             	mov    0x10(%edi),%eax
8010106b:	89 04 24             	mov    %eax,(%esp)
8010106e:	e8 3d 06 00 00       	call   801016b0 <ilock>
80101073:	89 74 24 0c          	mov    %esi,0xc(%esp)
80101077:	8b 47 14             	mov    0x14(%edi),%eax
8010107a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010107e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101081:	01 d8                	add    %ebx,%eax
80101083:	89 44 24 04          	mov    %eax,0x4(%esp)
80101087:	8b 47 10             	mov    0x10(%edi),%eax
8010108a:	89 04 24             	mov    %eax,(%esp)
8010108d:	e8 ce 09 00 00       	call   80101a60 <writei>
80101092:	85 c0                	test   %eax,%eax
80101094:	7f 92                	jg     80101028 <filewrite+0x48>
80101096:	8b 4f 10             	mov    0x10(%edi),%ecx
80101099:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010109c:	89 0c 24             	mov    %ecx,(%esp)
8010109f:	e8 ec 06 00 00       	call   80101790 <iunlock>
801010a4:	e8 d7 1a 00 00       	call   80102b80 <end_op>
801010a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010ac:	85 c0                	test   %eax,%eax
801010ae:	74 91                	je     80101041 <filewrite+0x61>
801010b0:	83 c4 2c             	add    $0x2c,%esp
801010b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801010b8:	5b                   	pop    %ebx
801010b9:	5e                   	pop    %esi
801010ba:	5f                   	pop    %edi
801010bb:	5d                   	pop    %ebp
801010bc:	c3                   	ret    
801010bd:	8d 76 00             	lea    0x0(%esi),%esi
801010c0:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
801010c3:	89 d8                	mov    %ebx,%eax
801010c5:	75 e9                	jne    801010b0 <filewrite+0xd0>
801010c7:	83 c4 2c             	add    $0x2c,%esp
801010ca:	5b                   	pop    %ebx
801010cb:	5e                   	pop    %esi
801010cc:	5f                   	pop    %edi
801010cd:	5d                   	pop    %ebp
801010ce:	c3                   	ret    
801010cf:	8b 47 0c             	mov    0xc(%edi),%eax
801010d2:	89 45 08             	mov    %eax,0x8(%ebp)
801010d5:	83 c4 2c             	add    $0x2c,%esp
801010d8:	5b                   	pop    %ebx
801010d9:	5e                   	pop    %esi
801010da:	5f                   	pop    %edi
801010db:	5d                   	pop    %ebp
801010dc:	e9 0f 22 00 00       	jmp    801032f0 <pipewrite>
801010e1:	c7 04 24 cf 70 10 80 	movl   $0x801070cf,(%esp)
801010e8:	e8 73 f2 ff ff       	call   80100360 <panic>
801010ed:	c7 04 24 d5 70 10 80 	movl   $0x801070d5,(%esp)
801010f4:	e8 67 f2 ff ff       	call   80100360 <panic>
801010f9:	66 90                	xchg   %ax,%ax
801010fb:	66 90                	xchg   %ax,%ax
801010fd:	66 90                	xchg   %ax,%ax
801010ff:	90                   	nop

80101100 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101100:	55                   	push   %ebp
80101101:	89 e5                	mov    %esp,%ebp
80101103:	57                   	push   %edi
80101104:	89 d7                	mov    %edx,%edi
80101106:	56                   	push   %esi
80101107:	53                   	push   %ebx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101108:	bb 01 00 00 00       	mov    $0x1,%ebx
{
8010110d:	83 ec 1c             	sub    $0x1c,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101110:	c1 ea 0c             	shr    $0xc,%edx
80101113:	03 15 d8 09 11 80    	add    0x801109d8,%edx
80101119:	89 04 24             	mov    %eax,(%esp)
8010111c:	89 54 24 04          	mov    %edx,0x4(%esp)
80101120:	e8 ab ef ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
80101125:	89 f9                	mov    %edi,%ecx
  bi = b % BPB;
80101127:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
8010112d:	89 fa                	mov    %edi,%edx
  m = 1 << (bi % 8);
8010112f:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101132:	c1 fa 03             	sar    $0x3,%edx
  m = 1 << (bi % 8);
80101135:	d3 e3                	shl    %cl,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101137:	89 c6                	mov    %eax,%esi
  if((bp->data[bi/8] & m) == 0)
80101139:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
8010113e:	0f b6 c8             	movzbl %al,%ecx
80101141:	85 d9                	test   %ebx,%ecx
80101143:	74 20                	je     80101165 <bfree+0x65>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101145:	f7 d3                	not    %ebx
80101147:	21 c3                	and    %eax,%ebx
80101149:	88 5c 16 5c          	mov    %bl,0x5c(%esi,%edx,1)
  log_write(bp);
8010114d:	89 34 24             	mov    %esi,(%esp)
80101150:	e8 5b 1b 00 00       	call   80102cb0 <log_write>
  brelse(bp);
80101155:	89 34 24             	mov    %esi,(%esp)
80101158:	e8 83 f0 ff ff       	call   801001e0 <brelse>
}
8010115d:	83 c4 1c             	add    $0x1c,%esp
80101160:	5b                   	pop    %ebx
80101161:	5e                   	pop    %esi
80101162:	5f                   	pop    %edi
80101163:	5d                   	pop    %ebp
80101164:	c3                   	ret    
    panic("freeing free block");
80101165:	c7 04 24 df 70 10 80 	movl   $0x801070df,(%esp)
8010116c:	e8 ef f1 ff ff       	call   80100360 <panic>
80101171:	eb 0d                	jmp    80101180 <balloc>
80101173:	90                   	nop
80101174:	90                   	nop
80101175:	90                   	nop
80101176:	90                   	nop
80101177:	90                   	nop
80101178:	90                   	nop
80101179:	90                   	nop
8010117a:	90                   	nop
8010117b:	90                   	nop
8010117c:	90                   	nop
8010117d:	90                   	nop
8010117e:	90                   	nop
8010117f:	90                   	nop

80101180 <balloc>:
{
80101180:	55                   	push   %ebp
80101181:	89 e5                	mov    %esp,%ebp
80101183:	57                   	push   %edi
80101184:	56                   	push   %esi
80101185:	53                   	push   %ebx
80101186:	83 ec 2c             	sub    $0x2c,%esp
80101189:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010118c:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101191:	85 c0                	test   %eax,%eax
80101193:	0f 84 8c 00 00 00    	je     80101225 <balloc+0xa5>
80101199:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
801011a0:	8b 75 dc             	mov    -0x24(%ebp),%esi
801011a3:	89 f0                	mov    %esi,%eax
801011a5:	c1 f8 0c             	sar    $0xc,%eax
801011a8:	03 05 d8 09 11 80    	add    0x801109d8,%eax
801011ae:	89 44 24 04          	mov    %eax,0x4(%esp)
801011b2:	8b 45 d8             	mov    -0x28(%ebp),%eax
801011b5:	89 04 24             	mov    %eax,(%esp)
801011b8:	e8 13 ef ff ff       	call   801000d0 <bread>
801011bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801011c0:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801011c5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011c8:	31 c0                	xor    %eax,%eax
801011ca:	eb 33                	jmp    801011ff <balloc+0x7f>
801011cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011d0:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801011d3:	89 c2                	mov    %eax,%edx
      m = 1 << (bi % 8);
801011d5:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011d7:	c1 fa 03             	sar    $0x3,%edx
      m = 1 << (bi % 8);
801011da:	83 e1 07             	and    $0x7,%ecx
801011dd:	bf 01 00 00 00       	mov    $0x1,%edi
801011e2:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011e4:	0f b6 5c 13 5c       	movzbl 0x5c(%ebx,%edx,1),%ebx
      m = 1 << (bi % 8);
801011e9:	89 f9                	mov    %edi,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801011eb:	0f b6 fb             	movzbl %bl,%edi
801011ee:	85 cf                	test   %ecx,%edi
801011f0:	74 46                	je     80101238 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801011f2:	83 c0 01             	add    $0x1,%eax
801011f5:	83 c6 01             	add    $0x1,%esi
801011f8:	3d 00 10 00 00       	cmp    $0x1000,%eax
801011fd:	74 05                	je     80101204 <balloc+0x84>
801011ff:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80101202:	72 cc                	jb     801011d0 <balloc+0x50>
    brelse(bp);
80101204:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101207:	89 04 24             	mov    %eax,(%esp)
8010120a:	e8 d1 ef ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010120f:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101216:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101219:	3b 05 c0 09 11 80    	cmp    0x801109c0,%eax
8010121f:	0f 82 7b ff ff ff    	jb     801011a0 <balloc+0x20>
  panic("balloc: out of blocks");
80101225:	c7 04 24 f2 70 10 80 	movl   $0x801070f2,(%esp)
8010122c:	e8 2f f1 ff ff       	call   80100360 <panic>
80101231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
80101238:	09 d9                	or     %ebx,%ecx
8010123a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010123d:	88 4c 13 5c          	mov    %cl,0x5c(%ebx,%edx,1)
        log_write(bp);
80101241:	89 1c 24             	mov    %ebx,(%esp)
80101244:	e8 67 1a 00 00       	call   80102cb0 <log_write>
        brelse(bp);
80101249:	89 1c 24             	mov    %ebx,(%esp)
8010124c:	e8 8f ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
80101251:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101254:	89 74 24 04          	mov    %esi,0x4(%esp)
80101258:	89 04 24             	mov    %eax,(%esp)
8010125b:	e8 70 ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101260:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80101267:	00 
80101268:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010126f:	00 
  bp = bread(dev, bno);
80101270:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101272:	8d 40 5c             	lea    0x5c(%eax),%eax
80101275:	89 04 24             	mov    %eax,(%esp)
80101278:	e8 13 33 00 00       	call   80104590 <memset>
  log_write(bp);
8010127d:	89 1c 24             	mov    %ebx,(%esp)
80101280:	e8 2b 1a 00 00       	call   80102cb0 <log_write>
  brelse(bp);
80101285:	89 1c 24             	mov    %ebx,(%esp)
80101288:	e8 53 ef ff ff       	call   801001e0 <brelse>
}
8010128d:	83 c4 2c             	add    $0x2c,%esp
80101290:	89 f0                	mov    %esi,%eax
80101292:	5b                   	pop    %ebx
80101293:	5e                   	pop    %esi
80101294:	5f                   	pop    %edi
80101295:	5d                   	pop    %ebp
80101296:	c3                   	ret    
80101297:	89 f6                	mov    %esi,%esi
80101299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801012a0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801012a0:	55                   	push   %ebp
801012a1:	89 e5                	mov    %esp,%ebp
801012a3:	57                   	push   %edi
801012a4:	89 c7                	mov    %eax,%edi
801012a6:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801012a7:	31 f6                	xor    %esi,%esi
{
801012a9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012aa:	bb 14 0a 11 80       	mov    $0x80110a14,%ebx
{
801012af:	83 ec 1c             	sub    $0x1c,%esp
  acquire(&icache.lock);
801012b2:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
{
801012b9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801012bc:	e8 0f 32 00 00       	call   801044d0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012c1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801012c4:	eb 14                	jmp    801012da <iget+0x3a>
801012c6:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801012c8:	85 f6                	test   %esi,%esi
801012ca:	74 3c                	je     80101308 <iget+0x68>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012cc:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012d2:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
801012d8:	74 46                	je     80101320 <iget+0x80>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012da:	8b 4b 08             	mov    0x8(%ebx),%ecx
801012dd:	85 c9                	test   %ecx,%ecx
801012df:	7e e7                	jle    801012c8 <iget+0x28>
801012e1:	39 3b                	cmp    %edi,(%ebx)
801012e3:	75 e3                	jne    801012c8 <iget+0x28>
801012e5:	39 53 04             	cmp    %edx,0x4(%ebx)
801012e8:	75 de                	jne    801012c8 <iget+0x28>
      ip->ref++;
801012ea:	83 c1 01             	add    $0x1,%ecx
      return ip;
801012ed:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801012ef:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
      ip->ref++;
801012f6:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012f9:	e8 42 32 00 00       	call   80104540 <release>
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
801012fe:	83 c4 1c             	add    $0x1c,%esp
80101301:	89 f0                	mov    %esi,%eax
80101303:	5b                   	pop    %ebx
80101304:	5e                   	pop    %esi
80101305:	5f                   	pop    %edi
80101306:	5d                   	pop    %ebp
80101307:	c3                   	ret    
80101308:	85 c9                	test   %ecx,%ecx
8010130a:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010130d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101313:	81 fb 34 26 11 80    	cmp    $0x80112634,%ebx
80101319:	75 bf                	jne    801012da <iget+0x3a>
8010131b:	90                   	nop
8010131c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(empty == 0)
80101320:	85 f6                	test   %esi,%esi
80101322:	74 29                	je     8010134d <iget+0xad>
  ip->dev = dev;
80101324:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101326:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101329:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101330:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101337:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010133e:	e8 fd 31 00 00       	call   80104540 <release>
}
80101343:	83 c4 1c             	add    $0x1c,%esp
80101346:	89 f0                	mov    %esi,%eax
80101348:	5b                   	pop    %ebx
80101349:	5e                   	pop    %esi
8010134a:	5f                   	pop    %edi
8010134b:	5d                   	pop    %ebp
8010134c:	c3                   	ret    
    panic("iget: no inodes");
8010134d:	c7 04 24 08 71 10 80 	movl   $0x80107108,(%esp)
80101354:	e8 07 f0 ff ff       	call   80100360 <panic>
80101359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101360 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101360:	55                   	push   %ebp
80101361:	89 e5                	mov    %esp,%ebp
80101363:	57                   	push   %edi
80101364:	56                   	push   %esi
80101365:	53                   	push   %ebx
80101366:	89 c3                	mov    %eax,%ebx
80101368:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010136b:	83 fa 0b             	cmp    $0xb,%edx
8010136e:	77 18                	ja     80101388 <bmap+0x28>
80101370:	8d 34 90             	lea    (%eax,%edx,4),%esi
    if((addr = ip->addrs[bn]) == 0)
80101373:	8b 46 5c             	mov    0x5c(%esi),%eax
80101376:	85 c0                	test   %eax,%eax
80101378:	74 66                	je     801013e0 <bmap+0x80>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010137a:	83 c4 1c             	add    $0x1c,%esp
8010137d:	5b                   	pop    %ebx
8010137e:	5e                   	pop    %esi
8010137f:	5f                   	pop    %edi
80101380:	5d                   	pop    %ebp
80101381:	c3                   	ret    
80101382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;
80101388:	8d 72 f4             	lea    -0xc(%edx),%esi
  if(bn < NINDIRECT){
8010138b:	83 fe 7f             	cmp    $0x7f,%esi
8010138e:	77 77                	ja     80101407 <bmap+0xa7>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101390:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101396:	85 c0                	test   %eax,%eax
80101398:	74 5e                	je     801013f8 <bmap+0x98>
    bp = bread(ip->dev, addr);
8010139a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010139e:	8b 03                	mov    (%ebx),%eax
801013a0:	89 04 24             	mov    %eax,(%esp)
801013a3:	e8 28 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
801013a8:	8d 54 b0 5c          	lea    0x5c(%eax,%esi,4),%edx
    bp = bread(ip->dev, addr);
801013ac:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
801013ae:	8b 32                	mov    (%edx),%esi
801013b0:	85 f6                	test   %esi,%esi
801013b2:	75 19                	jne    801013cd <bmap+0x6d>
      a[bn] = addr = balloc(ip->dev);
801013b4:	8b 03                	mov    (%ebx),%eax
801013b6:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801013b9:	e8 c2 fd ff ff       	call   80101180 <balloc>
801013be:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801013c1:	89 02                	mov    %eax,(%edx)
801013c3:	89 c6                	mov    %eax,%esi
      log_write(bp);
801013c5:	89 3c 24             	mov    %edi,(%esp)
801013c8:	e8 e3 18 00 00       	call   80102cb0 <log_write>
    brelse(bp);
801013cd:	89 3c 24             	mov    %edi,(%esp)
801013d0:	e8 0b ee ff ff       	call   801001e0 <brelse>
}
801013d5:	83 c4 1c             	add    $0x1c,%esp
    brelse(bp);
801013d8:	89 f0                	mov    %esi,%eax
}
801013da:	5b                   	pop    %ebx
801013db:	5e                   	pop    %esi
801013dc:	5f                   	pop    %edi
801013dd:	5d                   	pop    %ebp
801013de:	c3                   	ret    
801013df:	90                   	nop
      ip->addrs[bn] = addr = balloc(ip->dev);
801013e0:	8b 03                	mov    (%ebx),%eax
801013e2:	e8 99 fd ff ff       	call   80101180 <balloc>
801013e7:	89 46 5c             	mov    %eax,0x5c(%esi)
}
801013ea:	83 c4 1c             	add    $0x1c,%esp
801013ed:	5b                   	pop    %ebx
801013ee:	5e                   	pop    %esi
801013ef:	5f                   	pop    %edi
801013f0:	5d                   	pop    %ebp
801013f1:	c3                   	ret    
801013f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013f8:	8b 03                	mov    (%ebx),%eax
801013fa:	e8 81 fd ff ff       	call   80101180 <balloc>
801013ff:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
80101405:	eb 93                	jmp    8010139a <bmap+0x3a>
  panic("bmap: out of range");
80101407:	c7 04 24 18 71 10 80 	movl   $0x80107118,(%esp)
8010140e:	e8 4d ef ff ff       	call   80100360 <panic>
80101413:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101419:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101420 <readsb>:
{
80101420:	55                   	push   %ebp
80101421:	89 e5                	mov    %esp,%ebp
80101423:	56                   	push   %esi
80101424:	53                   	push   %ebx
80101425:	83 ec 10             	sub    $0x10,%esp
  bp = bread(dev, 1);
80101428:	8b 45 08             	mov    0x8(%ebp),%eax
8010142b:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80101432:	00 
{
80101433:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101436:	89 04 24             	mov    %eax,(%esp)
80101439:	e8 92 ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010143e:	89 34 24             	mov    %esi,(%esp)
80101441:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
80101448:	00 
  bp = bread(dev, 1);
80101449:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010144b:	8d 40 5c             	lea    0x5c(%eax),%eax
8010144e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101452:	e8 d9 31 00 00       	call   80104630 <memmove>
  brelse(bp);
80101457:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010145a:	83 c4 10             	add    $0x10,%esp
8010145d:	5b                   	pop    %ebx
8010145e:	5e                   	pop    %esi
8010145f:	5d                   	pop    %ebp
  brelse(bp);
80101460:	e9 7b ed ff ff       	jmp    801001e0 <brelse>
80101465:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101470 <iinit>:
{
80101470:	55                   	push   %ebp
80101471:	89 e5                	mov    %esp,%ebp
80101473:	53                   	push   %ebx
80101474:	bb 20 0a 11 80       	mov    $0x80110a20,%ebx
80101479:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
8010147c:	c7 44 24 04 2b 71 10 	movl   $0x8010712b,0x4(%esp)
80101483:	80 
80101484:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010148b:	e8 d0 2e 00 00       	call   80104360 <initlock>
    initsleeplock(&icache.inode[i].lock, "inode");
80101490:	89 1c 24             	mov    %ebx,(%esp)
80101493:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101499:	c7 44 24 04 32 71 10 	movl   $0x80107132,0x4(%esp)
801014a0:	80 
801014a1:	e8 8a 2d 00 00       	call   80104230 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014a6:	81 fb 40 26 11 80    	cmp    $0x80112640,%ebx
801014ac:	75 e2                	jne    80101490 <iinit+0x20>
  readsb(dev, &sb);
801014ae:	8b 45 08             	mov    0x8(%ebp),%eax
801014b1:	c7 44 24 04 c0 09 11 	movl   $0x801109c0,0x4(%esp)
801014b8:	80 
801014b9:	89 04 24             	mov    %eax,(%esp)
801014bc:	e8 5f ff ff ff       	call   80101420 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014c1:	a1 d8 09 11 80       	mov    0x801109d8,%eax
801014c6:	c7 04 24 98 71 10 80 	movl   $0x80107198,(%esp)
801014cd:	89 44 24 1c          	mov    %eax,0x1c(%esp)
801014d1:	a1 d4 09 11 80       	mov    0x801109d4,%eax
801014d6:	89 44 24 18          	mov    %eax,0x18(%esp)
801014da:	a1 d0 09 11 80       	mov    0x801109d0,%eax
801014df:	89 44 24 14          	mov    %eax,0x14(%esp)
801014e3:	a1 cc 09 11 80       	mov    0x801109cc,%eax
801014e8:	89 44 24 10          	mov    %eax,0x10(%esp)
801014ec:	a1 c8 09 11 80       	mov    0x801109c8,%eax
801014f1:	89 44 24 0c          	mov    %eax,0xc(%esp)
801014f5:	a1 c4 09 11 80       	mov    0x801109c4,%eax
801014fa:	89 44 24 08          	mov    %eax,0x8(%esp)
801014fe:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101503:	89 44 24 04          	mov    %eax,0x4(%esp)
80101507:	e8 44 f1 ff ff       	call   80100650 <cprintf>
}
8010150c:	83 c4 24             	add    $0x24,%esp
8010150f:	5b                   	pop    %ebx
80101510:	5d                   	pop    %ebp
80101511:	c3                   	ret    
80101512:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101519:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101520 <ialloc>:
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	57                   	push   %edi
80101524:	56                   	push   %esi
80101525:	53                   	push   %ebx
80101526:	83 ec 2c             	sub    $0x2c,%esp
80101529:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010152c:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
{
80101533:	8b 7d 08             	mov    0x8(%ebp),%edi
80101536:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101539:	0f 86 a2 00 00 00    	jbe    801015e1 <ialloc+0xc1>
8010153f:	be 01 00 00 00       	mov    $0x1,%esi
80101544:	bb 01 00 00 00       	mov    $0x1,%ebx
80101549:	eb 1a                	jmp    80101565 <ialloc+0x45>
8010154b:	90                   	nop
8010154c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    brelse(bp);
80101550:	89 14 24             	mov    %edx,(%esp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101553:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101556:	e8 85 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010155b:	89 de                	mov    %ebx,%esi
8010155d:	3b 1d c8 09 11 80    	cmp    0x801109c8,%ebx
80101563:	73 7c                	jae    801015e1 <ialloc+0xc1>
    bp = bread(dev, IBLOCK(inum, sb));
80101565:	89 f0                	mov    %esi,%eax
80101567:	c1 e8 03             	shr    $0x3,%eax
8010156a:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101570:	89 3c 24             	mov    %edi,(%esp)
80101573:	89 44 24 04          	mov    %eax,0x4(%esp)
80101577:	e8 54 eb ff ff       	call   801000d0 <bread>
8010157c:	89 c2                	mov    %eax,%edx
    dip = (struct dinode*)bp->data + inum%IPB;
8010157e:	89 f0                	mov    %esi,%eax
80101580:	83 e0 07             	and    $0x7,%eax
80101583:	c1 e0 06             	shl    $0x6,%eax
80101586:	8d 4c 02 5c          	lea    0x5c(%edx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010158a:	66 83 39 00          	cmpw   $0x0,(%ecx)
8010158e:	75 c0                	jne    80101550 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101590:	89 0c 24             	mov    %ecx,(%esp)
80101593:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
8010159a:	00 
8010159b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801015a2:	00 
801015a3:	89 55 dc             	mov    %edx,-0x24(%ebp)
801015a6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801015a9:	e8 e2 2f 00 00       	call   80104590 <memset>
      dip->type = type;
801015ae:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
      log_write(bp);   // mark it allocated on the disk
801015b2:	8b 55 dc             	mov    -0x24(%ebp),%edx
      dip->type = type;
801015b5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      log_write(bp);   // mark it allocated on the disk
801015b8:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      dip->type = type;
801015bb:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015be:	89 14 24             	mov    %edx,(%esp)
801015c1:	e8 ea 16 00 00       	call   80102cb0 <log_write>
      brelse(bp);
801015c6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015c9:	89 14 24             	mov    %edx,(%esp)
801015cc:	e8 0f ec ff ff       	call   801001e0 <brelse>
}
801015d1:	83 c4 2c             	add    $0x2c,%esp
      return iget(dev, inum);
801015d4:	89 f2                	mov    %esi,%edx
}
801015d6:	5b                   	pop    %ebx
      return iget(dev, inum);
801015d7:	89 f8                	mov    %edi,%eax
}
801015d9:	5e                   	pop    %esi
801015da:	5f                   	pop    %edi
801015db:	5d                   	pop    %ebp
      return iget(dev, inum);
801015dc:	e9 bf fc ff ff       	jmp    801012a0 <iget>
  panic("ialloc: no inodes");
801015e1:	c7 04 24 38 71 10 80 	movl   $0x80107138,(%esp)
801015e8:	e8 73 ed ff ff       	call   80100360 <panic>
801015ed:	8d 76 00             	lea    0x0(%esi),%esi

801015f0 <iupdate>:
{
801015f0:	55                   	push   %ebp
801015f1:	89 e5                	mov    %esp,%ebp
801015f3:	56                   	push   %esi
801015f4:	53                   	push   %ebx
801015f5:	83 ec 10             	sub    $0x10,%esp
801015f8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015fb:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015fe:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101601:	c1 e8 03             	shr    $0x3,%eax
80101604:	03 05 d4 09 11 80    	add    0x801109d4,%eax
8010160a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010160e:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80101611:	89 04 24             	mov    %eax,(%esp)
80101614:	e8 b7 ea ff ff       	call   801000d0 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101619:	8b 53 a8             	mov    -0x58(%ebx),%edx
8010161c:	83 e2 07             	and    $0x7,%edx
8010161f:	c1 e2 06             	shl    $0x6,%edx
80101622:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101626:	89 c6                	mov    %eax,%esi
  dip->type = ip->type;
80101628:	0f b7 43 f4          	movzwl -0xc(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010162c:	83 c2 0c             	add    $0xc,%edx
  dip->type = ip->type;
8010162f:	66 89 42 f4          	mov    %ax,-0xc(%edx)
  dip->major = ip->major;
80101633:	0f b7 43 f6          	movzwl -0xa(%ebx),%eax
80101637:	66 89 42 f6          	mov    %ax,-0xa(%edx)
  dip->minor = ip->minor;
8010163b:	0f b7 43 f8          	movzwl -0x8(%ebx),%eax
8010163f:	66 89 42 f8          	mov    %ax,-0x8(%edx)
  dip->nlink = ip->nlink;
80101643:	0f b7 43 fa          	movzwl -0x6(%ebx),%eax
80101647:	66 89 42 fa          	mov    %ax,-0x6(%edx)
  dip->size = ip->size;
8010164b:	8b 43 fc             	mov    -0x4(%ebx),%eax
8010164e:	89 42 fc             	mov    %eax,-0x4(%edx)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101651:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101655:	89 14 24             	mov    %edx,(%esp)
80101658:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
8010165f:	00 
80101660:	e8 cb 2f 00 00       	call   80104630 <memmove>
  log_write(bp);
80101665:	89 34 24             	mov    %esi,(%esp)
80101668:	e8 43 16 00 00       	call   80102cb0 <log_write>
  brelse(bp);
8010166d:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101670:	83 c4 10             	add    $0x10,%esp
80101673:	5b                   	pop    %ebx
80101674:	5e                   	pop    %esi
80101675:	5d                   	pop    %ebp
  brelse(bp);
80101676:	e9 65 eb ff ff       	jmp    801001e0 <brelse>
8010167b:	90                   	nop
8010167c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101680 <idup>:
{
80101680:	55                   	push   %ebp
80101681:	89 e5                	mov    %esp,%ebp
80101683:	53                   	push   %ebx
80101684:	83 ec 14             	sub    $0x14,%esp
80101687:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010168a:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101691:	e8 3a 2e 00 00       	call   801044d0 <acquire>
  ip->ref++;
80101696:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010169a:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801016a1:	e8 9a 2e 00 00       	call   80104540 <release>
}
801016a6:	83 c4 14             	add    $0x14,%esp
801016a9:	89 d8                	mov    %ebx,%eax
801016ab:	5b                   	pop    %ebx
801016ac:	5d                   	pop    %ebp
801016ad:	c3                   	ret    
801016ae:	66 90                	xchg   %ax,%ax

801016b0 <ilock>:
{
801016b0:	55                   	push   %ebp
801016b1:	89 e5                	mov    %esp,%ebp
801016b3:	56                   	push   %esi
801016b4:	53                   	push   %ebx
801016b5:	83 ec 10             	sub    $0x10,%esp
801016b8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801016bb:	85 db                	test   %ebx,%ebx
801016bd:	0f 84 b3 00 00 00    	je     80101776 <ilock+0xc6>
801016c3:	8b 53 08             	mov    0x8(%ebx),%edx
801016c6:	85 d2                	test   %edx,%edx
801016c8:	0f 8e a8 00 00 00    	jle    80101776 <ilock+0xc6>
  acquiresleep(&ip->lock);
801016ce:	8d 43 0c             	lea    0xc(%ebx),%eax
801016d1:	89 04 24             	mov    %eax,(%esp)
801016d4:	e8 97 2b 00 00       	call   80104270 <acquiresleep>
  if(ip->valid == 0){
801016d9:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016dc:	85 c0                	test   %eax,%eax
801016de:	74 08                	je     801016e8 <ilock+0x38>
}
801016e0:	83 c4 10             	add    $0x10,%esp
801016e3:	5b                   	pop    %ebx
801016e4:	5e                   	pop    %esi
801016e5:	5d                   	pop    %ebp
801016e6:	c3                   	ret    
801016e7:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016e8:	8b 43 04             	mov    0x4(%ebx),%eax
801016eb:	c1 e8 03             	shr    $0x3,%eax
801016ee:	03 05 d4 09 11 80    	add    0x801109d4,%eax
801016f4:	89 44 24 04          	mov    %eax,0x4(%esp)
801016f8:	8b 03                	mov    (%ebx),%eax
801016fa:	89 04 24             	mov    %eax,(%esp)
801016fd:	e8 ce e9 ff ff       	call   801000d0 <bread>
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101702:	8b 53 04             	mov    0x4(%ebx),%edx
80101705:	83 e2 07             	and    $0x7,%edx
80101708:	c1 e2 06             	shl    $0x6,%edx
8010170b:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010170f:	89 c6                	mov    %eax,%esi
    ip->type = dip->type;
80101711:	0f b7 02             	movzwl (%edx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101714:	83 c2 0c             	add    $0xc,%edx
    ip->type = dip->type;
80101717:	66 89 43 50          	mov    %ax,0x50(%ebx)
    ip->major = dip->major;
8010171b:	0f b7 42 f6          	movzwl -0xa(%edx),%eax
8010171f:	66 89 43 52          	mov    %ax,0x52(%ebx)
    ip->minor = dip->minor;
80101723:	0f b7 42 f8          	movzwl -0x8(%edx),%eax
80101727:	66 89 43 54          	mov    %ax,0x54(%ebx)
    ip->nlink = dip->nlink;
8010172b:	0f b7 42 fa          	movzwl -0x6(%edx),%eax
8010172f:	66 89 43 56          	mov    %ax,0x56(%ebx)
    ip->size = dip->size;
80101733:	8b 42 fc             	mov    -0x4(%edx),%eax
80101736:	89 43 58             	mov    %eax,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101739:	8d 43 5c             	lea    0x5c(%ebx),%eax
8010173c:	89 54 24 04          	mov    %edx,0x4(%esp)
80101740:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101747:	00 
80101748:	89 04 24             	mov    %eax,(%esp)
8010174b:	e8 e0 2e 00 00       	call   80104630 <memmove>
    brelse(bp);
80101750:	89 34 24             	mov    %esi,(%esp)
80101753:	e8 88 ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101758:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010175d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101764:	0f 85 76 ff ff ff    	jne    801016e0 <ilock+0x30>
      panic("ilock: no type");
8010176a:	c7 04 24 50 71 10 80 	movl   $0x80107150,(%esp)
80101771:	e8 ea eb ff ff       	call   80100360 <panic>
    panic("ilock");
80101776:	c7 04 24 4a 71 10 80 	movl   $0x8010714a,(%esp)
8010177d:	e8 de eb ff ff       	call   80100360 <panic>
80101782:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101790 <iunlock>:
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	56                   	push   %esi
80101794:	53                   	push   %ebx
80101795:	83 ec 10             	sub    $0x10,%esp
80101798:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010179b:	85 db                	test   %ebx,%ebx
8010179d:	74 24                	je     801017c3 <iunlock+0x33>
8010179f:	8d 73 0c             	lea    0xc(%ebx),%esi
801017a2:	89 34 24             	mov    %esi,(%esp)
801017a5:	e8 66 2b 00 00       	call   80104310 <holdingsleep>
801017aa:	85 c0                	test   %eax,%eax
801017ac:	74 15                	je     801017c3 <iunlock+0x33>
801017ae:	8b 43 08             	mov    0x8(%ebx),%eax
801017b1:	85 c0                	test   %eax,%eax
801017b3:	7e 0e                	jle    801017c3 <iunlock+0x33>
  releasesleep(&ip->lock);
801017b5:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017b8:	83 c4 10             	add    $0x10,%esp
801017bb:	5b                   	pop    %ebx
801017bc:	5e                   	pop    %esi
801017bd:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801017be:	e9 0d 2b 00 00       	jmp    801042d0 <releasesleep>
    panic("iunlock");
801017c3:	c7 04 24 5f 71 10 80 	movl   $0x8010715f,(%esp)
801017ca:	e8 91 eb ff ff       	call   80100360 <panic>
801017cf:	90                   	nop

801017d0 <iput>:
{
801017d0:	55                   	push   %ebp
801017d1:	89 e5                	mov    %esp,%ebp
801017d3:	57                   	push   %edi
801017d4:	56                   	push   %esi
801017d5:	53                   	push   %ebx
801017d6:	83 ec 1c             	sub    $0x1c,%esp
801017d9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
801017dc:	8d 7e 0c             	lea    0xc(%esi),%edi
801017df:	89 3c 24             	mov    %edi,(%esp)
801017e2:	e8 89 2a 00 00       	call   80104270 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017e7:	8b 56 4c             	mov    0x4c(%esi),%edx
801017ea:	85 d2                	test   %edx,%edx
801017ec:	74 07                	je     801017f5 <iput+0x25>
801017ee:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801017f3:	74 2b                	je     80101820 <iput+0x50>
  releasesleep(&ip->lock);
801017f5:	89 3c 24             	mov    %edi,(%esp)
801017f8:	e8 d3 2a 00 00       	call   801042d0 <releasesleep>
  acquire(&icache.lock);
801017fd:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101804:	e8 c7 2c 00 00       	call   801044d0 <acquire>
  ip->ref--;
80101809:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
8010180d:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
80101814:	83 c4 1c             	add    $0x1c,%esp
80101817:	5b                   	pop    %ebx
80101818:	5e                   	pop    %esi
80101819:	5f                   	pop    %edi
8010181a:	5d                   	pop    %ebp
  release(&icache.lock);
8010181b:	e9 20 2d 00 00       	jmp    80104540 <release>
    acquire(&icache.lock);
80101820:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101827:	e8 a4 2c 00 00       	call   801044d0 <acquire>
    int r = ip->ref;
8010182c:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
8010182f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101836:	e8 05 2d 00 00       	call   80104540 <release>
    if(r == 1){
8010183b:	83 fb 01             	cmp    $0x1,%ebx
8010183e:	75 b5                	jne    801017f5 <iput+0x25>
80101840:	8d 4e 30             	lea    0x30(%esi),%ecx
80101843:	89 f3                	mov    %esi,%ebx
80101845:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101848:	89 cf                	mov    %ecx,%edi
8010184a:	eb 0b                	jmp    80101857 <iput+0x87>
8010184c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101850:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101853:	39 fb                	cmp    %edi,%ebx
80101855:	74 19                	je     80101870 <iput+0xa0>
    if(ip->addrs[i]){
80101857:	8b 53 5c             	mov    0x5c(%ebx),%edx
8010185a:	85 d2                	test   %edx,%edx
8010185c:	74 f2                	je     80101850 <iput+0x80>
      bfree(ip->dev, ip->addrs[i]);
8010185e:	8b 06                	mov    (%esi),%eax
80101860:	e8 9b f8 ff ff       	call   80101100 <bfree>
      ip->addrs[i] = 0;
80101865:	c7 43 5c 00 00 00 00 	movl   $0x0,0x5c(%ebx)
8010186c:	eb e2                	jmp    80101850 <iput+0x80>
8010186e:	66 90                	xchg   %ax,%ax
    }
  }

  if(ip->addrs[NDIRECT]){
80101870:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101876:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101879:	85 c0                	test   %eax,%eax
8010187b:	75 2b                	jne    801018a8 <iput+0xd8>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
8010187d:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101884:	89 34 24             	mov    %esi,(%esp)
80101887:	e8 64 fd ff ff       	call   801015f0 <iupdate>
      ip->type = 0;
8010188c:	31 c0                	xor    %eax,%eax
8010188e:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
80101892:	89 34 24             	mov    %esi,(%esp)
80101895:	e8 56 fd ff ff       	call   801015f0 <iupdate>
      ip->valid = 0;
8010189a:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
801018a1:	e9 4f ff ff ff       	jmp    801017f5 <iput+0x25>
801018a6:	66 90                	xchg   %ax,%ax
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018a8:	89 44 24 04          	mov    %eax,0x4(%esp)
801018ac:	8b 06                	mov    (%esi),%eax
    for(j = 0; j < NINDIRECT; j++){
801018ae:	31 db                	xor    %ebx,%ebx
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018b0:	89 04 24             	mov    %eax,(%esp)
801018b3:	e8 18 e8 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
801018b8:	89 7d e0             	mov    %edi,-0x20(%ebp)
    a = (uint*)bp->data;
801018bb:	8d 48 5c             	lea    0x5c(%eax),%ecx
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801018c1:	89 cf                	mov    %ecx,%edi
801018c3:	31 c0                	xor    %eax,%eax
801018c5:	eb 0e                	jmp    801018d5 <iput+0x105>
801018c7:	90                   	nop
801018c8:	83 c3 01             	add    $0x1,%ebx
801018cb:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
801018d1:	89 d8                	mov    %ebx,%eax
801018d3:	74 10                	je     801018e5 <iput+0x115>
      if(a[j])
801018d5:	8b 14 87             	mov    (%edi,%eax,4),%edx
801018d8:	85 d2                	test   %edx,%edx
801018da:	74 ec                	je     801018c8 <iput+0xf8>
        bfree(ip->dev, a[j]);
801018dc:	8b 06                	mov    (%esi),%eax
801018de:	e8 1d f8 ff ff       	call   80101100 <bfree>
801018e3:	eb e3                	jmp    801018c8 <iput+0xf8>
    brelse(bp);
801018e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801018e8:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018eb:	89 04 24             	mov    %eax,(%esp)
801018ee:	e8 ed e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018f3:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801018f9:	8b 06                	mov    (%esi),%eax
801018fb:	e8 00 f8 ff ff       	call   80101100 <bfree>
    ip->addrs[NDIRECT] = 0;
80101900:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101907:	00 00 00 
8010190a:	e9 6e ff ff ff       	jmp    8010187d <iput+0xad>
8010190f:	90                   	nop

80101910 <iunlockput>:
{
80101910:	55                   	push   %ebp
80101911:	89 e5                	mov    %esp,%ebp
80101913:	53                   	push   %ebx
80101914:	83 ec 14             	sub    $0x14,%esp
80101917:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010191a:	89 1c 24             	mov    %ebx,(%esp)
8010191d:	e8 6e fe ff ff       	call   80101790 <iunlock>
  iput(ip);
80101922:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101925:	83 c4 14             	add    $0x14,%esp
80101928:	5b                   	pop    %ebx
80101929:	5d                   	pop    %ebp
  iput(ip);
8010192a:	e9 a1 fe ff ff       	jmp    801017d0 <iput>
8010192f:	90                   	nop

80101930 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101930:	55                   	push   %ebp
80101931:	89 e5                	mov    %esp,%ebp
80101933:	8b 55 08             	mov    0x8(%ebp),%edx
80101936:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101939:	8b 0a                	mov    (%edx),%ecx
8010193b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010193e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101941:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101944:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101948:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010194b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010194f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101953:	8b 52 58             	mov    0x58(%edx),%edx
80101956:	89 50 10             	mov    %edx,0x10(%eax)
}
80101959:	5d                   	pop    %ebp
8010195a:	c3                   	ret    
8010195b:	90                   	nop
8010195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101960 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	57                   	push   %edi
80101964:	56                   	push   %esi
80101965:	53                   	push   %ebx
80101966:	83 ec 2c             	sub    $0x2c,%esp
80101969:	8b 45 0c             	mov    0xc(%ebp),%eax
8010196c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010196f:	8b 75 10             	mov    0x10(%ebp),%esi
80101972:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101975:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101978:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
8010197d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101980:	0f 84 aa 00 00 00    	je     80101a30 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101986:	8b 47 58             	mov    0x58(%edi),%eax
80101989:	39 f0                	cmp    %esi,%eax
8010198b:	0f 82 c7 00 00 00    	jb     80101a58 <readi+0xf8>
80101991:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101994:	89 da                	mov    %ebx,%edx
80101996:	01 f2                	add    %esi,%edx
80101998:	0f 82 ba 00 00 00    	jb     80101a58 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
8010199e:	89 c1                	mov    %eax,%ecx
801019a0:	29 f1                	sub    %esi,%ecx
801019a2:	39 d0                	cmp    %edx,%eax
801019a4:	0f 43 cb             	cmovae %ebx,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019a7:	31 c0                	xor    %eax,%eax
801019a9:	85 c9                	test   %ecx,%ecx
    n = ip->size - off;
801019ab:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019ae:	74 70                	je     80101a20 <readi+0xc0>
801019b0:	89 7d d8             	mov    %edi,-0x28(%ebp)
801019b3:	89 c7                	mov    %eax,%edi
801019b5:	8d 76 00             	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019b8:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019bb:	89 f2                	mov    %esi,%edx
801019bd:	c1 ea 09             	shr    $0x9,%edx
801019c0:	89 d8                	mov    %ebx,%eax
801019c2:	e8 99 f9 ff ff       	call   80101360 <bmap>
801019c7:	89 44 24 04          	mov    %eax,0x4(%esp)
801019cb:	8b 03                	mov    (%ebx),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801019cd:	bb 00 02 00 00       	mov    $0x200,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019d2:	89 04 24             	mov    %eax,(%esp)
801019d5:	e8 f6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019da:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801019dd:	29 f9                	sub    %edi,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019df:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019e1:	89 f0                	mov    %esi,%eax
801019e3:	25 ff 01 00 00       	and    $0x1ff,%eax
801019e8:	29 c3                	sub    %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019ea:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801019ee:	39 cb                	cmp    %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019f0:	89 44 24 04          	mov    %eax,0x4(%esp)
801019f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801019f7:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
801019fa:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019fe:	01 df                	add    %ebx,%edi
80101a00:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a02:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101a05:	89 04 24             	mov    %eax,(%esp)
80101a08:	e8 23 2c 00 00       	call   80104630 <memmove>
    brelse(bp);
80101a0d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a10:	89 14 24             	mov    %edx,(%esp)
80101a13:	e8 c8 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a18:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a1b:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a1e:	77 98                	ja     801019b8 <readi+0x58>
  }
  return n;
80101a20:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a23:	83 c4 2c             	add    $0x2c,%esp
80101a26:	5b                   	pop    %ebx
80101a27:	5e                   	pop    %esi
80101a28:	5f                   	pop    %edi
80101a29:	5d                   	pop    %ebp
80101a2a:	c3                   	ret    
80101a2b:	90                   	nop
80101a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a30:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101a34:	66 83 f8 09          	cmp    $0x9,%ax
80101a38:	77 1e                	ja     80101a58 <readi+0xf8>
80101a3a:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101a41:	85 c0                	test   %eax,%eax
80101a43:	74 13                	je     80101a58 <readi+0xf8>
    return devsw[ip->major].read(ip, dst, n);
80101a45:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101a48:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101a4b:	83 c4 2c             	add    $0x2c,%esp
80101a4e:	5b                   	pop    %ebx
80101a4f:	5e                   	pop    %esi
80101a50:	5f                   	pop    %edi
80101a51:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a52:	ff e0                	jmp    *%eax
80101a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101a58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a5d:	eb c4                	jmp    80101a23 <readi+0xc3>
80101a5f:	90                   	nop

80101a60 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	57                   	push   %edi
80101a64:	56                   	push   %esi
80101a65:	53                   	push   %ebx
80101a66:	83 ec 2c             	sub    $0x2c,%esp
80101a69:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a6f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a72:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a77:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a7a:	8b 75 10             	mov    0x10(%ebp),%esi
80101a7d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a80:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  if(ip->type == T_DEV){
80101a83:	0f 84 b7 00 00 00    	je     80101b40 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a89:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a8c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a8f:	0f 82 e3 00 00 00    	jb     80101b78 <writei+0x118>
80101a95:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101a98:	89 c8                	mov    %ecx,%eax
80101a9a:	01 f0                	add    %esi,%eax
80101a9c:	0f 82 d6 00 00 00    	jb     80101b78 <writei+0x118>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101aa2:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101aa7:	0f 87 cb 00 00 00    	ja     80101b78 <writei+0x118>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101aad:	85 c9                	test   %ecx,%ecx
80101aaf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101ab6:	74 77                	je     80101b2f <writei+0xcf>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ab8:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101abb:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101abd:	bb 00 02 00 00       	mov    $0x200,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ac2:	c1 ea 09             	shr    $0x9,%edx
80101ac5:	89 f8                	mov    %edi,%eax
80101ac7:	e8 94 f8 ff ff       	call   80101360 <bmap>
80101acc:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ad0:	8b 07                	mov    (%edi),%eax
80101ad2:	89 04 24             	mov    %eax,(%esp)
80101ad5:	e8 f6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101ada:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101add:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101ae0:	8b 55 dc             	mov    -0x24(%ebp),%edx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ae3:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101ae5:	89 f0                	mov    %esi,%eax
80101ae7:	25 ff 01 00 00       	and    $0x1ff,%eax
80101aec:	29 c3                	sub    %eax,%ebx
80101aee:	39 cb                	cmp    %ecx,%ebx
80101af0:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101af3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101af7:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101af9:	89 54 24 04          	mov    %edx,0x4(%esp)
80101afd:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101b01:	89 04 24             	mov    %eax,(%esp)
80101b04:	e8 27 2b 00 00       	call   80104630 <memmove>
    log_write(bp);
80101b09:	89 3c 24             	mov    %edi,(%esp)
80101b0c:	e8 9f 11 00 00       	call   80102cb0 <log_write>
    brelse(bp);
80101b11:	89 3c 24             	mov    %edi,(%esp)
80101b14:	e8 c7 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b19:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b1c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b1f:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b22:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b25:	77 91                	ja     80101ab8 <writei+0x58>
  }

  if(n > 0 && off > ip->size){
80101b27:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b2a:	39 70 58             	cmp    %esi,0x58(%eax)
80101b2d:	72 39                	jb     80101b68 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b2f:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b32:	83 c4 2c             	add    $0x2c,%esp
80101b35:	5b                   	pop    %ebx
80101b36:	5e                   	pop    %esi
80101b37:	5f                   	pop    %edi
80101b38:	5d                   	pop    %ebp
80101b39:	c3                   	ret    
80101b3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b44:	66 83 f8 09          	cmp    $0x9,%ax
80101b48:	77 2e                	ja     80101b78 <writei+0x118>
80101b4a:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101b51:	85 c0                	test   %eax,%eax
80101b53:	74 23                	je     80101b78 <writei+0x118>
    return devsw[ip->major].write(ip, src, n);
80101b55:	89 4d 10             	mov    %ecx,0x10(%ebp)
}
80101b58:	83 c4 2c             	add    $0x2c,%esp
80101b5b:	5b                   	pop    %ebx
80101b5c:	5e                   	pop    %esi
80101b5d:	5f                   	pop    %edi
80101b5e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b5f:	ff e0                	jmp    *%eax
80101b61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b68:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b6b:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b6e:	89 04 24             	mov    %eax,(%esp)
80101b71:	e8 7a fa ff ff       	call   801015f0 <iupdate>
80101b76:	eb b7                	jmp    80101b2f <writei+0xcf>
}
80101b78:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80101b7b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101b80:	5b                   	pop    %ebx
80101b81:	5e                   	pop    %esi
80101b82:	5f                   	pop    %edi
80101b83:	5d                   	pop    %ebp
80101b84:	c3                   	ret    
80101b85:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101b90 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101b96:	8b 45 0c             	mov    0xc(%ebp),%eax
80101b99:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101ba0:	00 
80101ba1:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ba5:	8b 45 08             	mov    0x8(%ebp),%eax
80101ba8:	89 04 24             	mov    %eax,(%esp)
80101bab:	e8 00 2b 00 00       	call   801046b0 <strncmp>
}
80101bb0:	c9                   	leave  
80101bb1:	c3                   	ret    
80101bb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bc0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	57                   	push   %edi
80101bc4:	56                   	push   %esi
80101bc5:	53                   	push   %ebx
80101bc6:	83 ec 2c             	sub    $0x2c,%esp
80101bc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bcc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bd1:	0f 85 97 00 00 00    	jne    80101c6e <dirlookup+0xae>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bd7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bda:	31 ff                	xor    %edi,%edi
80101bdc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bdf:	85 d2                	test   %edx,%edx
80101be1:	75 0d                	jne    80101bf0 <dirlookup+0x30>
80101be3:	eb 73                	jmp    80101c58 <dirlookup+0x98>
80101be5:	8d 76 00             	lea    0x0(%esi),%esi
80101be8:	83 c7 10             	add    $0x10,%edi
80101beb:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101bee:	76 68                	jbe    80101c58 <dirlookup+0x98>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101bf0:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101bf7:	00 
80101bf8:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101bfc:	89 74 24 04          	mov    %esi,0x4(%esp)
80101c00:	89 1c 24             	mov    %ebx,(%esp)
80101c03:	e8 58 fd ff ff       	call   80101960 <readi>
80101c08:	83 f8 10             	cmp    $0x10,%eax
80101c0b:	75 55                	jne    80101c62 <dirlookup+0xa2>
      panic("dirlookup read");
    if(de.inum == 0)
80101c0d:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c12:	74 d4                	je     80101be8 <dirlookup+0x28>
  return strncmp(s, t, DIRSIZ);
80101c14:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c17:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c1b:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c1e:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101c25:	00 
80101c26:	89 04 24             	mov    %eax,(%esp)
80101c29:	e8 82 2a 00 00       	call   801046b0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c2e:	85 c0                	test   %eax,%eax
80101c30:	75 b6                	jne    80101be8 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101c32:	8b 45 10             	mov    0x10(%ebp),%eax
80101c35:	85 c0                	test   %eax,%eax
80101c37:	74 05                	je     80101c3e <dirlookup+0x7e>
        *poff = off;
80101c39:	8b 45 10             	mov    0x10(%ebp),%eax
80101c3c:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c3e:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c42:	8b 03                	mov    (%ebx),%eax
80101c44:	e8 57 f6 ff ff       	call   801012a0 <iget>
    }
  }

  return 0;
}
80101c49:	83 c4 2c             	add    $0x2c,%esp
80101c4c:	5b                   	pop    %ebx
80101c4d:	5e                   	pop    %esi
80101c4e:	5f                   	pop    %edi
80101c4f:	5d                   	pop    %ebp
80101c50:	c3                   	ret    
80101c51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c58:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80101c5b:	31 c0                	xor    %eax,%eax
}
80101c5d:	5b                   	pop    %ebx
80101c5e:	5e                   	pop    %esi
80101c5f:	5f                   	pop    %edi
80101c60:	5d                   	pop    %ebp
80101c61:	c3                   	ret    
      panic("dirlookup read");
80101c62:	c7 04 24 79 71 10 80 	movl   $0x80107179,(%esp)
80101c69:	e8 f2 e6 ff ff       	call   80100360 <panic>
    panic("dirlookup not DIR");
80101c6e:	c7 04 24 67 71 10 80 	movl   $0x80107167,(%esp)
80101c75:	e8 e6 e6 ff ff       	call   80100360 <panic>
80101c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101c80 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c80:	55                   	push   %ebp
80101c81:	89 e5                	mov    %esp,%ebp
80101c83:	57                   	push   %edi
80101c84:	89 cf                	mov    %ecx,%edi
80101c86:	56                   	push   %esi
80101c87:	53                   	push   %ebx
80101c88:	89 c3                	mov    %eax,%ebx
80101c8a:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c8d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c90:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c93:	0f 84 51 01 00 00    	je     80101dea <namex+0x16a>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c99:	e8 52 1a 00 00       	call   801036f0 <myproc>
80101c9e:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101ca1:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101ca8:	e8 23 28 00 00       	call   801044d0 <acquire>
  ip->ref++;
80101cad:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cb1:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101cb8:	e8 83 28 00 00       	call   80104540 <release>
80101cbd:	eb 04                	jmp    80101cc3 <namex+0x43>
80101cbf:	90                   	nop
    path++;
80101cc0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cc3:	0f b6 03             	movzbl (%ebx),%eax
80101cc6:	3c 2f                	cmp    $0x2f,%al
80101cc8:	74 f6                	je     80101cc0 <namex+0x40>
  if(*path == 0)
80101cca:	84 c0                	test   %al,%al
80101ccc:	0f 84 ed 00 00 00    	je     80101dbf <namex+0x13f>
  while(*path != '/' && *path != 0)
80101cd2:	0f b6 03             	movzbl (%ebx),%eax
80101cd5:	89 da                	mov    %ebx,%edx
80101cd7:	84 c0                	test   %al,%al
80101cd9:	0f 84 b1 00 00 00    	je     80101d90 <namex+0x110>
80101cdf:	3c 2f                	cmp    $0x2f,%al
80101ce1:	75 0f                	jne    80101cf2 <namex+0x72>
80101ce3:	e9 a8 00 00 00       	jmp    80101d90 <namex+0x110>
80101ce8:	3c 2f                	cmp    $0x2f,%al
80101cea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101cf0:	74 0a                	je     80101cfc <namex+0x7c>
    path++;
80101cf2:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101cf5:	0f b6 02             	movzbl (%edx),%eax
80101cf8:	84 c0                	test   %al,%al
80101cfa:	75 ec                	jne    80101ce8 <namex+0x68>
80101cfc:	89 d1                	mov    %edx,%ecx
80101cfe:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101d00:	83 f9 0d             	cmp    $0xd,%ecx
80101d03:	0f 8e 8f 00 00 00    	jle    80101d98 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101d09:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101d0d:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101d14:	00 
80101d15:	89 3c 24             	mov    %edi,(%esp)
80101d18:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d1b:	e8 10 29 00 00       	call   80104630 <memmove>
    path++;
80101d20:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101d23:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d25:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d28:	75 0e                	jne    80101d38 <namex+0xb8>
80101d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    path++;
80101d30:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d33:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d36:	74 f8                	je     80101d30 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d38:	89 34 24             	mov    %esi,(%esp)
80101d3b:	e8 70 f9 ff ff       	call   801016b0 <ilock>
    if(ip->type != T_DIR){
80101d40:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d45:	0f 85 85 00 00 00    	jne    80101dd0 <namex+0x150>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d4b:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d4e:	85 d2                	test   %edx,%edx
80101d50:	74 09                	je     80101d5b <namex+0xdb>
80101d52:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d55:	0f 84 a5 00 00 00    	je     80101e00 <namex+0x180>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d5b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101d62:	00 
80101d63:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101d67:	89 34 24             	mov    %esi,(%esp)
80101d6a:	e8 51 fe ff ff       	call   80101bc0 <dirlookup>
80101d6f:	85 c0                	test   %eax,%eax
80101d71:	74 5d                	je     80101dd0 <namex+0x150>
  iunlock(ip);
80101d73:	89 34 24             	mov    %esi,(%esp)
80101d76:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d79:	e8 12 fa ff ff       	call   80101790 <iunlock>
  iput(ip);
80101d7e:	89 34 24             	mov    %esi,(%esp)
80101d81:	e8 4a fa ff ff       	call   801017d0 <iput>
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101d86:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d89:	89 c6                	mov    %eax,%esi
80101d8b:	e9 33 ff ff ff       	jmp    80101cc3 <namex+0x43>
  while(*path != '/' && *path != 0)
80101d90:	31 c9                	xor    %ecx,%ecx
80101d92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(name, s, len);
80101d98:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101d9c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101da0:	89 3c 24             	mov    %edi,(%esp)
80101da3:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101da6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101da9:	e8 82 28 00 00       	call   80104630 <memmove>
    name[len] = 0;
80101dae:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101db1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101db4:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101db8:	89 d3                	mov    %edx,%ebx
80101dba:	e9 66 ff ff ff       	jmp    80101d25 <namex+0xa5>
  }
  if(nameiparent){
80101dbf:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101dc2:	85 c0                	test   %eax,%eax
80101dc4:	75 4c                	jne    80101e12 <namex+0x192>
80101dc6:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101dc8:	83 c4 2c             	add    $0x2c,%esp
80101dcb:	5b                   	pop    %ebx
80101dcc:	5e                   	pop    %esi
80101dcd:	5f                   	pop    %edi
80101dce:	5d                   	pop    %ebp
80101dcf:	c3                   	ret    
  iunlock(ip);
80101dd0:	89 34 24             	mov    %esi,(%esp)
80101dd3:	e8 b8 f9 ff ff       	call   80101790 <iunlock>
  iput(ip);
80101dd8:	89 34 24             	mov    %esi,(%esp)
80101ddb:	e8 f0 f9 ff ff       	call   801017d0 <iput>
}
80101de0:	83 c4 2c             	add    $0x2c,%esp
      return 0;
80101de3:	31 c0                	xor    %eax,%eax
}
80101de5:	5b                   	pop    %ebx
80101de6:	5e                   	pop    %esi
80101de7:	5f                   	pop    %edi
80101de8:	5d                   	pop    %ebp
80101de9:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101dea:	ba 01 00 00 00       	mov    $0x1,%edx
80101def:	b8 01 00 00 00       	mov    $0x1,%eax
80101df4:	e8 a7 f4 ff ff       	call   801012a0 <iget>
80101df9:	89 c6                	mov    %eax,%esi
80101dfb:	e9 c3 fe ff ff       	jmp    80101cc3 <namex+0x43>
      iunlock(ip);
80101e00:	89 34 24             	mov    %esi,(%esp)
80101e03:	e8 88 f9 ff ff       	call   80101790 <iunlock>
}
80101e08:	83 c4 2c             	add    $0x2c,%esp
      return ip;
80101e0b:	89 f0                	mov    %esi,%eax
}
80101e0d:	5b                   	pop    %ebx
80101e0e:	5e                   	pop    %esi
80101e0f:	5f                   	pop    %edi
80101e10:	5d                   	pop    %ebp
80101e11:	c3                   	ret    
    iput(ip);
80101e12:	89 34 24             	mov    %esi,(%esp)
80101e15:	e8 b6 f9 ff ff       	call   801017d0 <iput>
    return 0;
80101e1a:	31 c0                	xor    %eax,%eax
80101e1c:	eb aa                	jmp    80101dc8 <namex+0x148>
80101e1e:	66 90                	xchg   %ax,%ax

80101e20 <dirlink>:
{
80101e20:	55                   	push   %ebp
80101e21:	89 e5                	mov    %esp,%ebp
80101e23:	57                   	push   %edi
80101e24:	56                   	push   %esi
80101e25:	53                   	push   %ebx
80101e26:	83 ec 2c             	sub    $0x2c,%esp
80101e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e2c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e2f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101e36:	00 
80101e37:	89 1c 24             	mov    %ebx,(%esp)
80101e3a:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e3e:	e8 7d fd ff ff       	call   80101bc0 <dirlookup>
80101e43:	85 c0                	test   %eax,%eax
80101e45:	0f 85 8b 00 00 00    	jne    80101ed6 <dirlink+0xb6>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e4b:	8b 43 58             	mov    0x58(%ebx),%eax
80101e4e:	31 ff                	xor    %edi,%edi
80101e50:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e53:	85 c0                	test   %eax,%eax
80101e55:	75 13                	jne    80101e6a <dirlink+0x4a>
80101e57:	eb 35                	jmp    80101e8e <dirlink+0x6e>
80101e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e60:	8d 57 10             	lea    0x10(%edi),%edx
80101e63:	39 53 58             	cmp    %edx,0x58(%ebx)
80101e66:	89 d7                	mov    %edx,%edi
80101e68:	76 24                	jbe    80101e8e <dirlink+0x6e>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e6a:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101e71:	00 
80101e72:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101e76:	89 74 24 04          	mov    %esi,0x4(%esp)
80101e7a:	89 1c 24             	mov    %ebx,(%esp)
80101e7d:	e8 de fa ff ff       	call   80101960 <readi>
80101e82:	83 f8 10             	cmp    $0x10,%eax
80101e85:	75 5e                	jne    80101ee5 <dirlink+0xc5>
    if(de.inum == 0)
80101e87:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e8c:	75 d2                	jne    80101e60 <dirlink+0x40>
  strncpy(de.name, name, DIRSIZ);
80101e8e:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e91:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101e98:	00 
80101e99:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e9d:	8d 45 da             	lea    -0x26(%ebp),%eax
80101ea0:	89 04 24             	mov    %eax,(%esp)
80101ea3:	e8 78 28 00 00       	call   80104720 <strncpy>
  de.inum = inum;
80101ea8:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101eab:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101eb2:	00 
80101eb3:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101eb7:	89 74 24 04          	mov    %esi,0x4(%esp)
80101ebb:	89 1c 24             	mov    %ebx,(%esp)
  de.inum = inum;
80101ebe:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ec2:	e8 99 fb ff ff       	call   80101a60 <writei>
80101ec7:	83 f8 10             	cmp    $0x10,%eax
80101eca:	75 25                	jne    80101ef1 <dirlink+0xd1>
  return 0;
80101ecc:	31 c0                	xor    %eax,%eax
}
80101ece:	83 c4 2c             	add    $0x2c,%esp
80101ed1:	5b                   	pop    %ebx
80101ed2:	5e                   	pop    %esi
80101ed3:	5f                   	pop    %edi
80101ed4:	5d                   	pop    %ebp
80101ed5:	c3                   	ret    
    iput(ip);
80101ed6:	89 04 24             	mov    %eax,(%esp)
80101ed9:	e8 f2 f8 ff ff       	call   801017d0 <iput>
    return -1;
80101ede:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ee3:	eb e9                	jmp    80101ece <dirlink+0xae>
      panic("dirlink read");
80101ee5:	c7 04 24 88 71 10 80 	movl   $0x80107188,(%esp)
80101eec:	e8 6f e4 ff ff       	call   80100360 <panic>
    panic("dirlink");
80101ef1:	c7 04 24 ea 77 10 80 	movl   $0x801077ea,(%esp)
80101ef8:	e8 63 e4 ff ff       	call   80100360 <panic>
80101efd:	8d 76 00             	lea    0x0(%esi),%esi

80101f00 <namei>:

struct inode*
namei(char *path)
{
80101f00:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f01:	31 d2                	xor    %edx,%edx
{
80101f03:	89 e5                	mov    %esp,%ebp
80101f05:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101f08:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f0e:	e8 6d fd ff ff       	call   80101c80 <namex>
}
80101f13:	c9                   	leave  
80101f14:	c3                   	ret    
80101f15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f20 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f20:	55                   	push   %ebp
  return namex(path, 1, name);
80101f21:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f26:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f28:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f2b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f2e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f2f:	e9 4c fd ff ff       	jmp    80101c80 <namex>
80101f34:	66 90                	xchg   %ax,%ax
80101f36:	66 90                	xchg   %ax,%ax
80101f38:	66 90                	xchg   %ax,%ax
80101f3a:	66 90                	xchg   %ax,%ax
80101f3c:	66 90                	xchg   %ax,%ax
80101f3e:	66 90                	xchg   %ax,%ax

80101f40 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f40:	55                   	push   %ebp
80101f41:	89 e5                	mov    %esp,%ebp
80101f43:	56                   	push   %esi
80101f44:	89 c6                	mov    %eax,%esi
80101f46:	53                   	push   %ebx
80101f47:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
80101f4a:	85 c0                	test   %eax,%eax
80101f4c:	0f 84 99 00 00 00    	je     80101feb <idestart+0xab>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f52:	8b 48 08             	mov    0x8(%eax),%ecx
80101f55:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
80101f5b:	0f 87 7e 00 00 00    	ja     80101fdf <idestart+0x9f>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f61:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f66:	66 90                	xchg   %ax,%ax
80101f68:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f69:	83 e0 c0             	and    $0xffffffc0,%eax
80101f6c:	3c 40                	cmp    $0x40,%al
80101f6e:	75 f8                	jne    80101f68 <idestart+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f70:	31 db                	xor    %ebx,%ebx
80101f72:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f77:	89 d8                	mov    %ebx,%eax
80101f79:	ee                   	out    %al,(%dx)
80101f7a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f7f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f84:	ee                   	out    %al,(%dx)
80101f85:	0f b6 c1             	movzbl %cl,%eax
80101f88:	b2 f3                	mov    $0xf3,%dl
80101f8a:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f8b:	89 c8                	mov    %ecx,%eax
80101f8d:	b2 f4                	mov    $0xf4,%dl
80101f8f:	c1 f8 08             	sar    $0x8,%eax
80101f92:	ee                   	out    %al,(%dx)
80101f93:	b2 f5                	mov    $0xf5,%dl
80101f95:	89 d8                	mov    %ebx,%eax
80101f97:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101f98:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101f9c:	b2 f6                	mov    $0xf6,%dl
80101f9e:	83 e0 01             	and    $0x1,%eax
80101fa1:	c1 e0 04             	shl    $0x4,%eax
80101fa4:	83 c8 e0             	or     $0xffffffe0,%eax
80101fa7:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101fa8:	f6 06 04             	testb  $0x4,(%esi)
80101fab:	75 13                	jne    80101fc0 <idestart+0x80>
80101fad:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fb2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fb7:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fb8:	83 c4 10             	add    $0x10,%esp
80101fbb:	5b                   	pop    %ebx
80101fbc:	5e                   	pop    %esi
80101fbd:	5d                   	pop    %ebp
80101fbe:	c3                   	ret    
80101fbf:	90                   	nop
80101fc0:	b2 f7                	mov    $0xf7,%dl
80101fc2:	b8 30 00 00 00       	mov    $0x30,%eax
80101fc7:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101fc8:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101fcd:	83 c6 5c             	add    $0x5c,%esi
80101fd0:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fd5:	fc                   	cld    
80101fd6:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101fd8:	83 c4 10             	add    $0x10,%esp
80101fdb:	5b                   	pop    %ebx
80101fdc:	5e                   	pop    %esi
80101fdd:	5d                   	pop    %ebp
80101fde:	c3                   	ret    
    panic("incorrect blockno");
80101fdf:	c7 04 24 f4 71 10 80 	movl   $0x801071f4,(%esp)
80101fe6:	e8 75 e3 ff ff       	call   80100360 <panic>
    panic("idestart");
80101feb:	c7 04 24 eb 71 10 80 	movl   $0x801071eb,(%esp)
80101ff2:	e8 69 e3 ff ff       	call   80100360 <panic>
80101ff7:	89 f6                	mov    %esi,%esi
80101ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102000 <ideinit>:
{
80102000:	55                   	push   %ebp
80102001:	89 e5                	mov    %esp,%ebp
80102003:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
80102006:	c7 44 24 04 06 72 10 	movl   $0x80107206,0x4(%esp)
8010200d:	80 
8010200e:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102015:	e8 46 23 00 00       	call   80104360 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
8010201a:	a1 00 2d 11 80       	mov    0x80112d00,%eax
8010201f:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102026:	83 e8 01             	sub    $0x1,%eax
80102029:	89 44 24 04          	mov    %eax,0x4(%esp)
8010202d:	e8 7e 02 00 00       	call   801022b0 <ioapicenable>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102032:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102037:	90                   	nop
80102038:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102039:	83 e0 c0             	and    $0xffffffc0,%eax
8010203c:	3c 40                	cmp    $0x40,%al
8010203e:	75 f8                	jne    80102038 <ideinit+0x38>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102040:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102045:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010204a:	ee                   	out    %al,(%dx)
8010204b:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102050:	b2 f7                	mov    $0xf7,%dl
80102052:	eb 09                	jmp    8010205d <ideinit+0x5d>
80102054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<1000; i++){
80102058:	83 e9 01             	sub    $0x1,%ecx
8010205b:	74 0f                	je     8010206c <ideinit+0x6c>
8010205d:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
8010205e:	84 c0                	test   %al,%al
80102060:	74 f6                	je     80102058 <ideinit+0x58>
      havedisk1 = 1;
80102062:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102069:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010206c:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102071:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102076:	ee                   	out    %al,(%dx)
}
80102077:	c9                   	leave  
80102078:	c3                   	ret    
80102079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102080 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102080:	55                   	push   %ebp
80102081:	89 e5                	mov    %esp,%ebp
80102083:	57                   	push   %edi
80102084:	56                   	push   %esi
80102085:	53                   	push   %ebx
80102086:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102089:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102090:	e8 3b 24 00 00       	call   801044d0 <acquire>

  if((b = idequeue) == 0){
80102095:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
8010209b:	85 db                	test   %ebx,%ebx
8010209d:	74 30                	je     801020cf <ideintr+0x4f>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
8010209f:	8b 43 58             	mov    0x58(%ebx),%eax
801020a2:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020a7:	8b 33                	mov    (%ebx),%esi
801020a9:	f7 c6 04 00 00 00    	test   $0x4,%esi
801020af:	74 37                	je     801020e8 <ideintr+0x68>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020b1:	83 e6 fb             	and    $0xfffffffb,%esi
801020b4:	83 ce 02             	or     $0x2,%esi
801020b7:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801020b9:	89 1c 24             	mov    %ebx,(%esp)
801020bc:	e8 8f 1f 00 00       	call   80104050 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801020c1:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801020c6:	85 c0                	test   %eax,%eax
801020c8:	74 05                	je     801020cf <ideintr+0x4f>
    idestart(idequeue);
801020ca:	e8 71 fe ff ff       	call   80101f40 <idestart>
    release(&idelock);
801020cf:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
801020d6:	e8 65 24 00 00       	call   80104540 <release>

  release(&idelock);
}
801020db:	83 c4 1c             	add    $0x1c,%esp
801020de:	5b                   	pop    %ebx
801020df:	5e                   	pop    %esi
801020e0:	5f                   	pop    %edi
801020e1:	5d                   	pop    %ebp
801020e2:	c3                   	ret    
801020e3:	90                   	nop
801020e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020e8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020ed:	8d 76 00             	lea    0x0(%esi),%esi
801020f0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020f1:	89 c1                	mov    %eax,%ecx
801020f3:	83 e1 c0             	and    $0xffffffc0,%ecx
801020f6:	80 f9 40             	cmp    $0x40,%cl
801020f9:	75 f5                	jne    801020f0 <ideintr+0x70>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020fb:	a8 21                	test   $0x21,%al
801020fd:	75 b2                	jne    801020b1 <ideintr+0x31>
    insl(0x1f0, b->data, BSIZE/4);
801020ff:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102102:	b9 80 00 00 00       	mov    $0x80,%ecx
80102107:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010210c:	fc                   	cld    
8010210d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010210f:	8b 33                	mov    (%ebx),%esi
80102111:	eb 9e                	jmp    801020b1 <ideintr+0x31>
80102113:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102120 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102120:	55                   	push   %ebp
80102121:	89 e5                	mov    %esp,%ebp
80102123:	53                   	push   %ebx
80102124:	83 ec 14             	sub    $0x14,%esp
80102127:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010212a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010212d:	89 04 24             	mov    %eax,(%esp)
80102130:	e8 db 21 00 00       	call   80104310 <holdingsleep>
80102135:	85 c0                	test   %eax,%eax
80102137:	0f 84 9e 00 00 00    	je     801021db <iderw+0xbb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010213d:	8b 03                	mov    (%ebx),%eax
8010213f:	83 e0 06             	and    $0x6,%eax
80102142:	83 f8 02             	cmp    $0x2,%eax
80102145:	0f 84 a8 00 00 00    	je     801021f3 <iderw+0xd3>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010214b:	8b 53 04             	mov    0x4(%ebx),%edx
8010214e:	85 d2                	test   %edx,%edx
80102150:	74 0d                	je     8010215f <iderw+0x3f>
80102152:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102157:	85 c0                	test   %eax,%eax
80102159:	0f 84 88 00 00 00    	je     801021e7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
8010215f:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102166:	e8 65 23 00 00       	call   801044d0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010216b:	a1 64 a5 10 80       	mov    0x8010a564,%eax
  b->qnext = 0;
80102170:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102177:	85 c0                	test   %eax,%eax
80102179:	75 07                	jne    80102182 <iderw+0x62>
8010217b:	eb 4e                	jmp    801021cb <iderw+0xab>
8010217d:	8d 76 00             	lea    0x0(%esi),%esi
80102180:	89 d0                	mov    %edx,%eax
80102182:	8b 50 58             	mov    0x58(%eax),%edx
80102185:	85 d2                	test   %edx,%edx
80102187:	75 f7                	jne    80102180 <iderw+0x60>
80102189:	83 c0 58             	add    $0x58,%eax
    ;
  *pp = b;
8010218c:	89 18                	mov    %ebx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
8010218e:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
80102194:	74 3c                	je     801021d2 <iderw+0xb2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102196:	8b 03                	mov    (%ebx),%eax
80102198:	83 e0 06             	and    $0x6,%eax
8010219b:	83 f8 02             	cmp    $0x2,%eax
8010219e:	74 1a                	je     801021ba <iderw+0x9a>
    sleep(b, &idelock);
801021a0:	c7 44 24 04 80 a5 10 	movl   $0x8010a580,0x4(%esp)
801021a7:	80 
801021a8:	89 1c 24             	mov    %ebx,(%esp)
801021ab:	e8 f0 1b 00 00       	call   80103da0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021b0:	8b 13                	mov    (%ebx),%edx
801021b2:	83 e2 06             	and    $0x6,%edx
801021b5:	83 fa 02             	cmp    $0x2,%edx
801021b8:	75 e6                	jne    801021a0 <iderw+0x80>
  }


  release(&idelock);
801021ba:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021c1:	83 c4 14             	add    $0x14,%esp
801021c4:	5b                   	pop    %ebx
801021c5:	5d                   	pop    %ebp
  release(&idelock);
801021c6:	e9 75 23 00 00       	jmp    80104540 <release>
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021cb:	b8 64 a5 10 80       	mov    $0x8010a564,%eax
801021d0:	eb ba                	jmp    8010218c <iderw+0x6c>
    idestart(b);
801021d2:	89 d8                	mov    %ebx,%eax
801021d4:	e8 67 fd ff ff       	call   80101f40 <idestart>
801021d9:	eb bb                	jmp    80102196 <iderw+0x76>
    panic("iderw: buf not locked");
801021db:	c7 04 24 0a 72 10 80 	movl   $0x8010720a,(%esp)
801021e2:	e8 79 e1 ff ff       	call   80100360 <panic>
    panic("iderw: ide disk 1 not present");
801021e7:	c7 04 24 35 72 10 80 	movl   $0x80107235,(%esp)
801021ee:	e8 6d e1 ff ff       	call   80100360 <panic>
    panic("iderw: nothing to do");
801021f3:	c7 04 24 20 72 10 80 	movl   $0x80107220,(%esp)
801021fa:	e8 61 e1 ff ff       	call   80100360 <panic>
801021ff:	90                   	nop

80102200 <ioapicinit>:
80102200:	55                   	push   %ebp
80102201:	89 e5                	mov    %esp,%ebp
80102203:	56                   	push   %esi
80102204:	53                   	push   %ebx
80102205:	83 ec 10             	sub    $0x10,%esp
80102208:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
8010220f:	00 c0 fe 
80102212:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102219:	00 00 00 
8010221c:	8b 15 34 26 11 80    	mov    0x80112634,%edx
80102222:	8b 42 10             	mov    0x10(%edx),%eax
80102225:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
8010222b:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
80102231:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
80102238:	c1 e8 10             	shr    $0x10,%eax
8010223b:	0f b6 f0             	movzbl %al,%esi
8010223e:	8b 43 10             	mov    0x10(%ebx),%eax
80102241:	c1 e8 18             	shr    $0x18,%eax
80102244:	39 c2                	cmp    %eax,%edx
80102246:	74 12                	je     8010225a <ioapicinit+0x5a>
80102248:	c7 04 24 54 72 10 80 	movl   $0x80107254,(%esp)
8010224f:	e8 fc e3 ff ff       	call   80100650 <cprintf>
80102254:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
8010225a:	ba 10 00 00 00       	mov    $0x10,%edx
8010225f:	31 c0                	xor    %eax,%eax
80102261:	eb 07                	jmp    8010226a <ioapicinit+0x6a>
80102263:	90                   	nop
80102264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102268:	89 cb                	mov    %ecx,%ebx
8010226a:	89 13                	mov    %edx,(%ebx)
8010226c:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
80102272:	8d 48 20             	lea    0x20(%eax),%ecx
80102275:	81 c9 00 00 01 00    	or     $0x10000,%ecx
8010227b:	83 c0 01             	add    $0x1,%eax
8010227e:	89 4b 10             	mov    %ecx,0x10(%ebx)
80102281:	8d 4a 01             	lea    0x1(%edx),%ecx
80102284:	83 c2 02             	add    $0x2,%edx
80102287:	89 0b                	mov    %ecx,(%ebx)
80102289:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010228f:	39 c6                	cmp    %eax,%esi
80102291:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
80102298:	7d ce                	jge    80102268 <ioapicinit+0x68>
8010229a:	83 c4 10             	add    $0x10,%esp
8010229d:	5b                   	pop    %ebx
8010229e:	5e                   	pop    %esi
8010229f:	5d                   	pop    %ebp
801022a0:	c3                   	ret    
801022a1:	eb 0d                	jmp    801022b0 <ioapicenable>
801022a3:	90                   	nop
801022a4:	90                   	nop
801022a5:	90                   	nop
801022a6:	90                   	nop
801022a7:	90                   	nop
801022a8:	90                   	nop
801022a9:	90                   	nop
801022aa:	90                   	nop
801022ab:	90                   	nop
801022ac:	90                   	nop
801022ad:	90                   	nop
801022ae:	90                   	nop
801022af:	90                   	nop

801022b0 <ioapicenable>:
801022b0:	55                   	push   %ebp
801022b1:	89 e5                	mov    %esp,%ebp
801022b3:	8b 55 08             	mov    0x8(%ebp),%edx
801022b6:	53                   	push   %ebx
801022b7:	8b 45 0c             	mov    0xc(%ebp),%eax
801022ba:	8d 5a 20             	lea    0x20(%edx),%ebx
801022bd:	8d 4c 12 10          	lea    0x10(%edx,%edx,1),%ecx
801022c1:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801022c7:	c1 e0 18             	shl    $0x18,%eax
801022ca:	89 0a                	mov    %ecx,(%edx)
801022cc:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801022d2:	83 c1 01             	add    $0x1,%ecx
801022d5:	89 5a 10             	mov    %ebx,0x10(%edx)
801022d8:	89 0a                	mov    %ecx,(%edx)
801022da:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801022e0:	89 42 10             	mov    %eax,0x10(%edx)
801022e3:	5b                   	pop    %ebx
801022e4:	5d                   	pop    %ebp
801022e5:	c3                   	ret    
801022e6:	66 90                	xchg   %ax,%ax
801022e8:	66 90                	xchg   %ax,%ax
801022ea:	66 90                	xchg   %ax,%ax
801022ec:	66 90                	xchg   %ax,%ax
801022ee:	66 90                	xchg   %ax,%ax

801022f0 <kfree>:
801022f0:	55                   	push   %ebp
801022f1:	89 e5                	mov    %esp,%ebp
801022f3:	53                   	push   %ebx
801022f4:	83 ec 14             	sub    $0x14,%esp
801022f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801022fa:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102300:	75 7c                	jne    8010237e <kfree+0x8e>
80102302:	81 fb a8 58 11 80    	cmp    $0x801158a8,%ebx
80102308:	72 74                	jb     8010237e <kfree+0x8e>
8010230a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102310:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102315:	77 67                	ja     8010237e <kfree+0x8e>
80102317:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010231e:	00 
8010231f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102326:	00 
80102327:	89 1c 24             	mov    %ebx,(%esp)
8010232a:	e8 61 22 00 00       	call   80104590 <memset>
8010232f:	8b 15 74 26 11 80    	mov    0x80112674,%edx
80102335:	85 d2                	test   %edx,%edx
80102337:	75 37                	jne    80102370 <kfree+0x80>
80102339:	a1 78 26 11 80       	mov    0x80112678,%eax
8010233e:	89 03                	mov    %eax,(%ebx)
80102340:	a1 74 26 11 80       	mov    0x80112674,%eax
80102345:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
8010234b:	85 c0                	test   %eax,%eax
8010234d:	75 09                	jne    80102358 <kfree+0x68>
8010234f:	83 c4 14             	add    $0x14,%esp
80102352:	5b                   	pop    %ebx
80102353:	5d                   	pop    %ebp
80102354:	c3                   	ret    
80102355:	8d 76 00             	lea    0x0(%esi),%esi
80102358:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
8010235f:	83 c4 14             	add    $0x14,%esp
80102362:	5b                   	pop    %ebx
80102363:	5d                   	pop    %ebp
80102364:	e9 d7 21 00 00       	jmp    80104540 <release>
80102369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102370:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
80102377:	e8 54 21 00 00       	call   801044d0 <acquire>
8010237c:	eb bb                	jmp    80102339 <kfree+0x49>
8010237e:	c7 04 24 86 72 10 80 	movl   $0x80107286,(%esp)
80102385:	e8 d6 df ff ff       	call   80100360 <panic>
8010238a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102390 <freerange>:
80102390:	55                   	push   %ebp
80102391:	89 e5                	mov    %esp,%ebp
80102393:	56                   	push   %esi
80102394:	53                   	push   %ebx
80102395:	83 ec 10             	sub    $0x10,%esp
80102398:	8b 45 08             	mov    0x8(%ebp),%eax
8010239b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010239e:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801023a4:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801023aa:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
801023b0:	39 de                	cmp    %ebx,%esi
801023b2:	73 08                	jae    801023bc <freerange+0x2c>
801023b4:	eb 18                	jmp    801023ce <freerange+0x3e>
801023b6:	66 90                	xchg   %ax,%ax
801023b8:	89 da                	mov    %ebx,%edx
801023ba:	89 c3                	mov    %eax,%ebx
801023bc:	89 14 24             	mov    %edx,(%esp)
801023bf:	e8 2c ff ff ff       	call   801022f0 <kfree>
801023c4:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
801023ca:	39 f0                	cmp    %esi,%eax
801023cc:	76 ea                	jbe    801023b8 <freerange+0x28>
801023ce:	83 c4 10             	add    $0x10,%esp
801023d1:	5b                   	pop    %ebx
801023d2:	5e                   	pop    %esi
801023d3:	5d                   	pop    %ebp
801023d4:	c3                   	ret    
801023d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801023d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801023e0 <kinit1>:
801023e0:	55                   	push   %ebp
801023e1:	89 e5                	mov    %esp,%ebp
801023e3:	56                   	push   %esi
801023e4:	53                   	push   %ebx
801023e5:	83 ec 10             	sub    $0x10,%esp
801023e8:	8b 75 0c             	mov    0xc(%ebp),%esi
801023eb:	c7 44 24 04 8c 72 10 	movl   $0x8010728c,0x4(%esp)
801023f2:	80 
801023f3:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801023fa:	e8 61 1f 00 00       	call   80104360 <initlock>
801023ff:	8b 45 08             	mov    0x8(%ebp),%eax
80102402:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102409:	00 00 00 
8010240c:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102412:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80102418:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
8010241e:	39 de                	cmp    %ebx,%esi
80102420:	73 0a                	jae    8010242c <kinit1+0x4c>
80102422:	eb 1a                	jmp    8010243e <kinit1+0x5e>
80102424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102428:	89 da                	mov    %ebx,%edx
8010242a:	89 c3                	mov    %eax,%ebx
8010242c:	89 14 24             	mov    %edx,(%esp)
8010242f:	e8 bc fe ff ff       	call   801022f0 <kfree>
80102434:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
8010243a:	39 c6                	cmp    %eax,%esi
8010243c:	73 ea                	jae    80102428 <kinit1+0x48>
8010243e:	83 c4 10             	add    $0x10,%esp
80102441:	5b                   	pop    %ebx
80102442:	5e                   	pop    %esi
80102443:	5d                   	pop    %ebp
80102444:	c3                   	ret    
80102445:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102450 <kinit2>:
80102450:	55                   	push   %ebp
80102451:	89 e5                	mov    %esp,%ebp
80102453:	56                   	push   %esi
80102454:	53                   	push   %ebx
80102455:	83 ec 10             	sub    $0x10,%esp
80102458:	8b 45 08             	mov    0x8(%ebp),%eax
8010245b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010245e:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102464:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
8010246a:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
80102470:	39 de                	cmp    %ebx,%esi
80102472:	73 08                	jae    8010247c <kinit2+0x2c>
80102474:	eb 18                	jmp    8010248e <kinit2+0x3e>
80102476:	66 90                	xchg   %ax,%ax
80102478:	89 da                	mov    %ebx,%edx
8010247a:	89 c3                	mov    %eax,%ebx
8010247c:	89 14 24             	mov    %edx,(%esp)
8010247f:	e8 6c fe ff ff       	call   801022f0 <kfree>
80102484:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
8010248a:	39 c6                	cmp    %eax,%esi
8010248c:	73 ea                	jae    80102478 <kinit2+0x28>
8010248e:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
80102495:	00 00 00 
80102498:	83 c4 10             	add    $0x10,%esp
8010249b:	5b                   	pop    %ebx
8010249c:	5e                   	pop    %esi
8010249d:	5d                   	pop    %ebp
8010249e:	c3                   	ret    
8010249f:	90                   	nop

801024a0 <kalloc>:
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	53                   	push   %ebx
801024a4:	83 ec 14             	sub    $0x14,%esp
801024a7:	a1 74 26 11 80       	mov    0x80112674,%eax
801024ac:	85 c0                	test   %eax,%eax
801024ae:	75 30                	jne    801024e0 <kalloc+0x40>
801024b0:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
801024b6:	85 db                	test   %ebx,%ebx
801024b8:	74 08                	je     801024c2 <kalloc+0x22>
801024ba:	8b 13                	mov    (%ebx),%edx
801024bc:	89 15 78 26 11 80    	mov    %edx,0x80112678
801024c2:	85 c0                	test   %eax,%eax
801024c4:	74 0c                	je     801024d2 <kalloc+0x32>
801024c6:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801024cd:	e8 6e 20 00 00       	call   80104540 <release>
801024d2:	83 c4 14             	add    $0x14,%esp
801024d5:	89 d8                	mov    %ebx,%eax
801024d7:	5b                   	pop    %ebx
801024d8:	5d                   	pop    %ebp
801024d9:	c3                   	ret    
801024da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801024e0:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801024e7:	e8 e4 1f 00 00       	call   801044d0 <acquire>
801024ec:	a1 74 26 11 80       	mov    0x80112674,%eax
801024f1:	eb bd                	jmp    801024b0 <kalloc+0x10>
801024f3:	66 90                	xchg   %ax,%ax
801024f5:	66 90                	xchg   %ax,%ax
801024f7:	66 90                	xchg   %ax,%ax
801024f9:	66 90                	xchg   %ax,%ax
801024fb:	66 90                	xchg   %ax,%ax
801024fd:	66 90                	xchg   %ax,%ax
801024ff:	90                   	nop

80102500 <kbdgetc>:
80102500:	ba 64 00 00 00       	mov    $0x64,%edx
80102505:	ec                   	in     (%dx),%al
80102506:	a8 01                	test   $0x1,%al
80102508:	0f 84 ba 00 00 00    	je     801025c8 <kbdgetc+0xc8>
8010250e:	b2 60                	mov    $0x60,%dl
80102510:	ec                   	in     (%dx),%al
80102511:	0f b6 c8             	movzbl %al,%ecx
80102514:	81 f9 e0 00 00 00    	cmp    $0xe0,%ecx
8010251a:	0f 84 88 00 00 00    	je     801025a8 <kbdgetc+0xa8>
80102520:	84 c0                	test   %al,%al
80102522:	79 2c                	jns    80102550 <kbdgetc+0x50>
80102524:	8b 15 b4 a5 10 80    	mov    0x8010a5b4,%edx
8010252a:	f6 c2 40             	test   $0x40,%dl
8010252d:	75 05                	jne    80102534 <kbdgetc+0x34>
8010252f:	89 c1                	mov    %eax,%ecx
80102531:	83 e1 7f             	and    $0x7f,%ecx
80102534:	0f b6 81 c0 73 10 80 	movzbl -0x7fef8c40(%ecx),%eax
8010253b:	83 c8 40             	or     $0x40,%eax
8010253e:	0f b6 c0             	movzbl %al,%eax
80102541:	f7 d0                	not    %eax
80102543:	21 d0                	and    %edx,%eax
80102545:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
8010254a:	31 c0                	xor    %eax,%eax
8010254c:	c3                   	ret    
8010254d:	8d 76 00             	lea    0x0(%esi),%esi
80102550:	55                   	push   %ebp
80102551:	89 e5                	mov    %esp,%ebp
80102553:	53                   	push   %ebx
80102554:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
8010255a:	f6 c3 40             	test   $0x40,%bl
8010255d:	74 09                	je     80102568 <kbdgetc+0x68>
8010255f:	83 c8 80             	or     $0xffffff80,%eax
80102562:	83 e3 bf             	and    $0xffffffbf,%ebx
80102565:	0f b6 c8             	movzbl %al,%ecx
80102568:	0f b6 91 c0 73 10 80 	movzbl -0x7fef8c40(%ecx),%edx
8010256f:	0f b6 81 c0 72 10 80 	movzbl -0x7fef8d40(%ecx),%eax
80102576:	09 da                	or     %ebx,%edx
80102578:	31 c2                	xor    %eax,%edx
8010257a:	89 d0                	mov    %edx,%eax
8010257c:	83 e0 03             	and    $0x3,%eax
8010257f:	8b 04 85 a0 72 10 80 	mov    -0x7fef8d60(,%eax,4),%eax
80102586:	89 15 b4 a5 10 80    	mov    %edx,0x8010a5b4
8010258c:	83 e2 08             	and    $0x8,%edx
8010258f:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
80102593:	74 0b                	je     801025a0 <kbdgetc+0xa0>
80102595:	8d 50 9f             	lea    -0x61(%eax),%edx
80102598:	83 fa 19             	cmp    $0x19,%edx
8010259b:	77 1b                	ja     801025b8 <kbdgetc+0xb8>
8010259d:	83 e8 20             	sub    $0x20,%eax
801025a0:	5b                   	pop    %ebx
801025a1:	5d                   	pop    %ebp
801025a2:	c3                   	ret    
801025a3:	90                   	nop
801025a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025a8:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
801025af:	31 c0                	xor    %eax,%eax
801025b1:	c3                   	ret    
801025b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801025b8:	8d 48 bf             	lea    -0x41(%eax),%ecx
801025bb:	8d 50 20             	lea    0x20(%eax),%edx
801025be:	83 f9 19             	cmp    $0x19,%ecx
801025c1:	0f 46 c2             	cmovbe %edx,%eax
801025c4:	eb da                	jmp    801025a0 <kbdgetc+0xa0>
801025c6:	66 90                	xchg   %ax,%ax
801025c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025cd:	c3                   	ret    
801025ce:	66 90                	xchg   %ax,%ax

801025d0 <kbdintr>:
801025d0:	55                   	push   %ebp
801025d1:	89 e5                	mov    %esp,%ebp
801025d3:	83 ec 18             	sub    $0x18,%esp
801025d6:	c7 04 24 00 25 10 80 	movl   $0x80102500,(%esp)
801025dd:	e8 ce e1 ff ff       	call   801007b0 <consoleintr>
801025e2:	c9                   	leave  
801025e3:	c3                   	ret    
801025e4:	66 90                	xchg   %ax,%ax
801025e6:	66 90                	xchg   %ax,%ax
801025e8:	66 90                	xchg   %ax,%ax
801025ea:	66 90                	xchg   %ax,%ax
801025ec:	66 90                	xchg   %ax,%ax
801025ee:	66 90                	xchg   %ax,%ax

801025f0 <fill_rtcdate>:
801025f0:	55                   	push   %ebp
801025f1:	89 c1                	mov    %eax,%ecx
801025f3:	89 e5                	mov    %esp,%ebp
801025f5:	ba 70 00 00 00       	mov    $0x70,%edx
801025fa:	53                   	push   %ebx
801025fb:	31 c0                	xor    %eax,%eax
801025fd:	ee                   	out    %al,(%dx)
801025fe:	bb 71 00 00 00       	mov    $0x71,%ebx
80102603:	89 da                	mov    %ebx,%edx
80102605:	ec                   	in     (%dx),%al
80102606:	0f b6 c0             	movzbl %al,%eax
80102609:	b2 70                	mov    $0x70,%dl
8010260b:	89 01                	mov    %eax,(%ecx)
8010260d:	b8 02 00 00 00       	mov    $0x2,%eax
80102612:	ee                   	out    %al,(%dx)
80102613:	89 da                	mov    %ebx,%edx
80102615:	ec                   	in     (%dx),%al
80102616:	0f b6 c0             	movzbl %al,%eax
80102619:	b2 70                	mov    $0x70,%dl
8010261b:	89 41 04             	mov    %eax,0x4(%ecx)
8010261e:	b8 04 00 00 00       	mov    $0x4,%eax
80102623:	ee                   	out    %al,(%dx)
80102624:	89 da                	mov    %ebx,%edx
80102626:	ec                   	in     (%dx),%al
80102627:	0f b6 c0             	movzbl %al,%eax
8010262a:	b2 70                	mov    $0x70,%dl
8010262c:	89 41 08             	mov    %eax,0x8(%ecx)
8010262f:	b8 07 00 00 00       	mov    $0x7,%eax
80102634:	ee                   	out    %al,(%dx)
80102635:	89 da                	mov    %ebx,%edx
80102637:	ec                   	in     (%dx),%al
80102638:	0f b6 c0             	movzbl %al,%eax
8010263b:	b2 70                	mov    $0x70,%dl
8010263d:	89 41 0c             	mov    %eax,0xc(%ecx)
80102640:	b8 08 00 00 00       	mov    $0x8,%eax
80102645:	ee                   	out    %al,(%dx)
80102646:	89 da                	mov    %ebx,%edx
80102648:	ec                   	in     (%dx),%al
80102649:	0f b6 c0             	movzbl %al,%eax
8010264c:	b2 70                	mov    $0x70,%dl
8010264e:	89 41 10             	mov    %eax,0x10(%ecx)
80102651:	b8 09 00 00 00       	mov    $0x9,%eax
80102656:	ee                   	out    %al,(%dx)
80102657:	89 da                	mov    %ebx,%edx
80102659:	ec                   	in     (%dx),%al
8010265a:	0f b6 d8             	movzbl %al,%ebx
8010265d:	89 59 14             	mov    %ebx,0x14(%ecx)
80102660:	5b                   	pop    %ebx
80102661:	5d                   	pop    %ebp
80102662:	c3                   	ret    
80102663:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102670 <lapicinit>:
80102670:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102675:	55                   	push   %ebp
80102676:	89 e5                	mov    %esp,%ebp
80102678:	85 c0                	test   %eax,%eax
8010267a:	0f 84 c0 00 00 00    	je     80102740 <lapicinit+0xd0>
80102680:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102687:	01 00 00 
8010268a:	8b 50 20             	mov    0x20(%eax),%edx
8010268d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102694:	00 00 00 
80102697:	8b 50 20             	mov    0x20(%eax),%edx
8010269a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801026a1:	00 02 00 
801026a4:	8b 50 20             	mov    0x20(%eax),%edx
801026a7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801026ae:	96 98 00 
801026b1:	8b 50 20             	mov    0x20(%eax),%edx
801026b4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801026bb:	00 01 00 
801026be:	8b 50 20             	mov    0x20(%eax),%edx
801026c1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801026c8:	00 01 00 
801026cb:	8b 50 20             	mov    0x20(%eax),%edx
801026ce:	8b 50 30             	mov    0x30(%eax),%edx
801026d1:	c1 ea 10             	shr    $0x10,%edx
801026d4:	80 fa 03             	cmp    $0x3,%dl
801026d7:	77 6f                	ja     80102748 <lapicinit+0xd8>
801026d9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026e0:	00 00 00 
801026e3:	8b 50 20             	mov    0x20(%eax),%edx
801026e6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ed:	00 00 00 
801026f0:	8b 50 20             	mov    0x20(%eax),%edx
801026f3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026fa:	00 00 00 
801026fd:	8b 50 20             	mov    0x20(%eax),%edx
80102700:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102707:	00 00 00 
8010270a:	8b 50 20             	mov    0x20(%eax),%edx
8010270d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102714:	00 00 00 
80102717:	8b 50 20             	mov    0x20(%eax),%edx
8010271a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102721:	85 08 00 
80102724:	8b 50 20             	mov    0x20(%eax),%edx
80102727:	90                   	nop
80102728:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010272e:	80 e6 10             	and    $0x10,%dh
80102731:	75 f5                	jne    80102728 <lapicinit+0xb8>
80102733:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010273a:	00 00 00 
8010273d:	8b 40 20             	mov    0x20(%eax),%eax
80102740:	5d                   	pop    %ebp
80102741:	c3                   	ret    
80102742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102748:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010274f:	00 01 00 
80102752:	8b 50 20             	mov    0x20(%eax),%edx
80102755:	eb 82                	jmp    801026d9 <lapicinit+0x69>
80102757:	89 f6                	mov    %esi,%esi
80102759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102760 <lapicid>:
80102760:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102765:	55                   	push   %ebp
80102766:	89 e5                	mov    %esp,%ebp
80102768:	85 c0                	test   %eax,%eax
8010276a:	74 0c                	je     80102778 <lapicid+0x18>
8010276c:	8b 40 20             	mov    0x20(%eax),%eax
8010276f:	5d                   	pop    %ebp
80102770:	c1 e8 18             	shr    $0x18,%eax
80102773:	c3                   	ret    
80102774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102778:	31 c0                	xor    %eax,%eax
8010277a:	5d                   	pop    %ebp
8010277b:	c3                   	ret    
8010277c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102780 <lapiceoi>:
80102780:	a1 7c 26 11 80       	mov    0x8011267c,%eax
80102785:	55                   	push   %ebp
80102786:	89 e5                	mov    %esp,%ebp
80102788:	85 c0                	test   %eax,%eax
8010278a:	74 0d                	je     80102799 <lapiceoi+0x19>
8010278c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102793:	00 00 00 
80102796:	8b 40 20             	mov    0x20(%eax),%eax
80102799:	5d                   	pop    %ebp
8010279a:	c3                   	ret    
8010279b:	90                   	nop
8010279c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027a0 <microdelay>:
801027a0:	55                   	push   %ebp
801027a1:	89 e5                	mov    %esp,%ebp
801027a3:	5d                   	pop    %ebp
801027a4:	c3                   	ret    
801027a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027b0 <lapicstartap>:
801027b0:	55                   	push   %ebp
801027b1:	ba 70 00 00 00       	mov    $0x70,%edx
801027b6:	89 e5                	mov    %esp,%ebp
801027b8:	b8 0f 00 00 00       	mov    $0xf,%eax
801027bd:	53                   	push   %ebx
801027be:	8b 4d 08             	mov    0x8(%ebp),%ecx
801027c1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801027c4:	ee                   	out    %al,(%dx)
801027c5:	b8 0a 00 00 00       	mov    $0xa,%eax
801027ca:	b2 71                	mov    $0x71,%dl
801027cc:	ee                   	out    %al,(%dx)
801027cd:	31 c0                	xor    %eax,%eax
801027cf:	66 a3 67 04 00 80    	mov    %ax,0x80000467
801027d5:	89 d8                	mov    %ebx,%eax
801027d7:	c1 e8 04             	shr    $0x4,%eax
801027da:	66 a3 69 04 00 80    	mov    %ax,0x80000469
801027e0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
801027e5:	c1 e1 18             	shl    $0x18,%ecx
801027e8:	c1 eb 0c             	shr    $0xc,%ebx
801027eb:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
801027f1:	8b 50 20             	mov    0x20(%eax),%edx
801027f4:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027fb:	c5 00 00 
801027fe:	8b 50 20             	mov    0x20(%eax),%edx
80102801:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102808:	85 00 00 
8010280b:	8b 50 20             	mov    0x20(%eax),%edx
8010280e:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
80102814:	8b 50 20             	mov    0x20(%eax),%edx
80102817:	89 da                	mov    %ebx,%edx
80102819:	80 ce 06             	or     $0x6,%dh
8010281c:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
80102822:	8b 58 20             	mov    0x20(%eax),%ebx
80102825:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
8010282b:	8b 48 20             	mov    0x20(%eax),%ecx
8010282e:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
80102834:	8b 40 20             	mov    0x20(%eax),%eax
80102837:	5b                   	pop    %ebx
80102838:	5d                   	pop    %ebp
80102839:	c3                   	ret    
8010283a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102840 <cmostime>:
80102840:	55                   	push   %ebp
80102841:	ba 70 00 00 00       	mov    $0x70,%edx
80102846:	89 e5                	mov    %esp,%ebp
80102848:	b8 0b 00 00 00       	mov    $0xb,%eax
8010284d:	57                   	push   %edi
8010284e:	56                   	push   %esi
8010284f:	53                   	push   %ebx
80102850:	83 ec 4c             	sub    $0x4c,%esp
80102853:	ee                   	out    %al,(%dx)
80102854:	b2 71                	mov    $0x71,%dl
80102856:	ec                   	in     (%dx),%al
80102857:	88 45 b7             	mov    %al,-0x49(%ebp)
8010285a:	8d 5d b8             	lea    -0x48(%ebp),%ebx
8010285d:	80 65 b7 04          	andb   $0x4,-0x49(%ebp)
80102861:	8d 7d d0             	lea    -0x30(%ebp),%edi
80102864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102868:	be 70 00 00 00       	mov    $0x70,%esi
8010286d:	89 d8                	mov    %ebx,%eax
8010286f:	e8 7c fd ff ff       	call   801025f0 <fill_rtcdate>
80102874:	b8 0a 00 00 00       	mov    $0xa,%eax
80102879:	89 f2                	mov    %esi,%edx
8010287b:	ee                   	out    %al,(%dx)
8010287c:	ba 71 00 00 00       	mov    $0x71,%edx
80102881:	ec                   	in     (%dx),%al
80102882:	84 c0                	test   %al,%al
80102884:	78 e7                	js     8010286d <cmostime+0x2d>
80102886:	89 f8                	mov    %edi,%eax
80102888:	e8 63 fd ff ff       	call   801025f0 <fill_rtcdate>
8010288d:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
80102894:	00 
80102895:	89 7c 24 04          	mov    %edi,0x4(%esp)
80102899:	89 1c 24             	mov    %ebx,(%esp)
8010289c:	e8 3f 1d 00 00       	call   801045e0 <memcmp>
801028a1:	85 c0                	test   %eax,%eax
801028a3:	75 c3                	jne    80102868 <cmostime+0x28>
801028a5:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
801028a9:	75 78                	jne    80102923 <cmostime+0xe3>
801028ab:	8b 45 b8             	mov    -0x48(%ebp),%eax
801028ae:	89 c2                	mov    %eax,%edx
801028b0:	83 e0 0f             	and    $0xf,%eax
801028b3:	c1 ea 04             	shr    $0x4,%edx
801028b6:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028b9:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028bc:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028bf:	8b 45 bc             	mov    -0x44(%ebp),%eax
801028c2:	89 c2                	mov    %eax,%edx
801028c4:	83 e0 0f             	and    $0xf,%eax
801028c7:	c1 ea 04             	shr    $0x4,%edx
801028ca:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028cd:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028d0:	89 45 bc             	mov    %eax,-0x44(%ebp)
801028d3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801028d6:	89 c2                	mov    %eax,%edx
801028d8:	83 e0 0f             	and    $0xf,%eax
801028db:	c1 ea 04             	shr    $0x4,%edx
801028de:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028e1:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028e4:	89 45 c0             	mov    %eax,-0x40(%ebp)
801028e7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801028ea:	89 c2                	mov    %eax,%edx
801028ec:	83 e0 0f             	and    $0xf,%eax
801028ef:	c1 ea 04             	shr    $0x4,%edx
801028f2:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028f5:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028f8:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801028fb:	8b 45 c8             	mov    -0x38(%ebp),%eax
801028fe:	89 c2                	mov    %eax,%edx
80102900:	83 e0 0f             	and    $0xf,%eax
80102903:	c1 ea 04             	shr    $0x4,%edx
80102906:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102909:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010290c:	89 45 c8             	mov    %eax,-0x38(%ebp)
8010290f:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102912:	89 c2                	mov    %eax,%edx
80102914:	83 e0 0f             	and    $0xf,%eax
80102917:	c1 ea 04             	shr    $0x4,%edx
8010291a:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010291d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102920:	89 45 cc             	mov    %eax,-0x34(%ebp)
80102923:	8b 4d 08             	mov    0x8(%ebp),%ecx
80102926:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102929:	89 01                	mov    %eax,(%ecx)
8010292b:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010292e:	89 41 04             	mov    %eax,0x4(%ecx)
80102931:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102934:	89 41 08             	mov    %eax,0x8(%ecx)
80102937:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010293a:	89 41 0c             	mov    %eax,0xc(%ecx)
8010293d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102940:	89 41 10             	mov    %eax,0x10(%ecx)
80102943:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102946:	89 41 14             	mov    %eax,0x14(%ecx)
80102949:	81 41 14 d0 07 00 00 	addl   $0x7d0,0x14(%ecx)
80102950:	83 c4 4c             	add    $0x4c,%esp
80102953:	5b                   	pop    %ebx
80102954:	5e                   	pop    %esi
80102955:	5f                   	pop    %edi
80102956:	5d                   	pop    %ebp
80102957:	c3                   	ret    
80102958:	66 90                	xchg   %ax,%ax
8010295a:	66 90                	xchg   %ax,%ax
8010295c:	66 90                	xchg   %ax,%ax
8010295e:	66 90                	xchg   %ax,%ax

80102960 <install_trans>:
80102960:	55                   	push   %ebp
80102961:	89 e5                	mov    %esp,%ebp
80102963:	57                   	push   %edi
80102964:	56                   	push   %esi
80102965:	53                   	push   %ebx
80102966:	31 db                	xor    %ebx,%ebx
80102968:	83 ec 1c             	sub    $0x1c,%esp
8010296b:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102970:	85 c0                	test   %eax,%eax
80102972:	7e 78                	jle    801029ec <install_trans+0x8c>
80102974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102978:	a1 b4 26 11 80       	mov    0x801126b4,%eax
8010297d:	01 d8                	add    %ebx,%eax
8010297f:	83 c0 01             	add    $0x1,%eax
80102982:	89 44 24 04          	mov    %eax,0x4(%esp)
80102986:	a1 c4 26 11 80       	mov    0x801126c4,%eax
8010298b:	89 04 24             	mov    %eax,(%esp)
8010298e:	e8 3d d7 ff ff       	call   801000d0 <bread>
80102993:	89 c7                	mov    %eax,%edi
80102995:	8b 04 9d cc 26 11 80 	mov    -0x7feed934(,%ebx,4),%eax
8010299c:	83 c3 01             	add    $0x1,%ebx
8010299f:	89 44 24 04          	mov    %eax,0x4(%esp)
801029a3:	a1 c4 26 11 80       	mov    0x801126c4,%eax
801029a8:	89 04 24             	mov    %eax,(%esp)
801029ab:	e8 20 d7 ff ff       	call   801000d0 <bread>
801029b0:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801029b7:	00 
801029b8:	89 c6                	mov    %eax,%esi
801029ba:	8d 47 5c             	lea    0x5c(%edi),%eax
801029bd:	89 44 24 04          	mov    %eax,0x4(%esp)
801029c1:	8d 46 5c             	lea    0x5c(%esi),%eax
801029c4:	89 04 24             	mov    %eax,(%esp)
801029c7:	e8 64 1c 00 00       	call   80104630 <memmove>
801029cc:	89 34 24             	mov    %esi,(%esp)
801029cf:	e8 cc d7 ff ff       	call   801001a0 <bwrite>
801029d4:	89 3c 24             	mov    %edi,(%esp)
801029d7:	e8 04 d8 ff ff       	call   801001e0 <brelse>
801029dc:	89 34 24             	mov    %esi,(%esp)
801029df:	e8 fc d7 ff ff       	call   801001e0 <brelse>
801029e4:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
801029ea:	7f 8c                	jg     80102978 <install_trans+0x18>
801029ec:	83 c4 1c             	add    $0x1c,%esp
801029ef:	5b                   	pop    %ebx
801029f0:	5e                   	pop    %esi
801029f1:	5f                   	pop    %edi
801029f2:	5d                   	pop    %ebp
801029f3:	c3                   	ret    
801029f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801029fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102a00 <write_head>:
80102a00:	55                   	push   %ebp
80102a01:	89 e5                	mov    %esp,%ebp
80102a03:	57                   	push   %edi
80102a04:	56                   	push   %esi
80102a05:	53                   	push   %ebx
80102a06:	83 ec 1c             	sub    $0x1c,%esp
80102a09:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102a0e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a12:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102a17:	89 04 24             	mov    %eax,(%esp)
80102a1a:	e8 b1 d6 ff ff       	call   801000d0 <bread>
80102a1f:	8b 1d c8 26 11 80    	mov    0x801126c8,%ebx
80102a25:	31 d2                	xor    %edx,%edx
80102a27:	85 db                	test   %ebx,%ebx
80102a29:	89 c7                	mov    %eax,%edi
80102a2b:	89 58 5c             	mov    %ebx,0x5c(%eax)
80102a2e:	8d 70 5c             	lea    0x5c(%eax),%esi
80102a31:	7e 17                	jle    80102a4a <write_head+0x4a>
80102a33:	90                   	nop
80102a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a38:	8b 0c 95 cc 26 11 80 	mov    -0x7feed934(,%edx,4),%ecx
80102a3f:	89 4c 96 04          	mov    %ecx,0x4(%esi,%edx,4)
80102a43:	83 c2 01             	add    $0x1,%edx
80102a46:	39 da                	cmp    %ebx,%edx
80102a48:	75 ee                	jne    80102a38 <write_head+0x38>
80102a4a:	89 3c 24             	mov    %edi,(%esp)
80102a4d:	e8 4e d7 ff ff       	call   801001a0 <bwrite>
80102a52:	89 3c 24             	mov    %edi,(%esp)
80102a55:	e8 86 d7 ff ff       	call   801001e0 <brelse>
80102a5a:	83 c4 1c             	add    $0x1c,%esp
80102a5d:	5b                   	pop    %ebx
80102a5e:	5e                   	pop    %esi
80102a5f:	5f                   	pop    %edi
80102a60:	5d                   	pop    %ebp
80102a61:	c3                   	ret    
80102a62:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102a70 <initlog>:
80102a70:	55                   	push   %ebp
80102a71:	89 e5                	mov    %esp,%ebp
80102a73:	56                   	push   %esi
80102a74:	53                   	push   %ebx
80102a75:	83 ec 30             	sub    $0x30,%esp
80102a78:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102a7b:	c7 44 24 04 c0 74 10 	movl   $0x801074c0,0x4(%esp)
80102a82:	80 
80102a83:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102a8a:	e8 d1 18 00 00       	call   80104360 <initlock>
80102a8f:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102a92:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a96:	89 1c 24             	mov    %ebx,(%esp)
80102a99:	e8 82 e9 ff ff       	call   80101420 <readsb>
80102a9e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102aa1:	8b 55 e8             	mov    -0x18(%ebp),%edx
80102aa4:	89 1c 24             	mov    %ebx,(%esp)
80102aa7:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4
80102aad:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ab1:	89 15 b8 26 11 80    	mov    %edx,0x801126b8
80102ab7:	a3 b4 26 11 80       	mov    %eax,0x801126b4
80102abc:	e8 0f d6 ff ff       	call   801000d0 <bread>
80102ac1:	31 d2                	xor    %edx,%edx
80102ac3:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102ac6:	8d 70 5c             	lea    0x5c(%eax),%esi
80102ac9:	85 db                	test   %ebx,%ebx
80102acb:	89 1d c8 26 11 80    	mov    %ebx,0x801126c8
80102ad1:	7e 17                	jle    80102aea <initlog+0x7a>
80102ad3:	90                   	nop
80102ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ad8:	8b 4c 96 04          	mov    0x4(%esi,%edx,4),%ecx
80102adc:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
80102ae3:	83 c2 01             	add    $0x1,%edx
80102ae6:	39 da                	cmp    %ebx,%edx
80102ae8:	75 ee                	jne    80102ad8 <initlog+0x68>
80102aea:	89 04 24             	mov    %eax,(%esp)
80102aed:	e8 ee d6 ff ff       	call   801001e0 <brelse>
80102af2:	e8 69 fe ff ff       	call   80102960 <install_trans>
80102af7:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102afe:	00 00 00 
80102b01:	e8 fa fe ff ff       	call   80102a00 <write_head>
80102b06:	83 c4 30             	add    $0x30,%esp
80102b09:	5b                   	pop    %ebx
80102b0a:	5e                   	pop    %esi
80102b0b:	5d                   	pop    %ebp
80102b0c:	c3                   	ret    
80102b0d:	8d 76 00             	lea    0x0(%esi),%esi

80102b10 <begin_op>:
80102b10:	55                   	push   %ebp
80102b11:	89 e5                	mov    %esp,%ebp
80102b13:	83 ec 18             	sub    $0x18,%esp
80102b16:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102b1d:	e8 ae 19 00 00       	call   801044d0 <acquire>
80102b22:	eb 18                	jmp    80102b3c <begin_op+0x2c>
80102b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b28:	c7 44 24 04 80 26 11 	movl   $0x80112680,0x4(%esp)
80102b2f:	80 
80102b30:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102b37:	e8 64 12 00 00       	call   80103da0 <sleep>
80102b3c:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102b41:	85 c0                	test   %eax,%eax
80102b43:	75 e3                	jne    80102b28 <begin_op+0x18>
80102b45:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102b4a:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102b50:	83 c0 01             	add    $0x1,%eax
80102b53:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102b56:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102b59:	83 fa 1e             	cmp    $0x1e,%edx
80102b5c:	7f ca                	jg     80102b28 <begin_op+0x18>
80102b5e:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102b65:	a3 bc 26 11 80       	mov    %eax,0x801126bc
80102b6a:	e8 d1 19 00 00       	call   80104540 <release>
80102b6f:	c9                   	leave  
80102b70:	c3                   	ret    
80102b71:	eb 0d                	jmp    80102b80 <end_op>
80102b73:	90                   	nop
80102b74:	90                   	nop
80102b75:	90                   	nop
80102b76:	90                   	nop
80102b77:	90                   	nop
80102b78:	90                   	nop
80102b79:	90                   	nop
80102b7a:	90                   	nop
80102b7b:	90                   	nop
80102b7c:	90                   	nop
80102b7d:	90                   	nop
80102b7e:	90                   	nop
80102b7f:	90                   	nop

80102b80 <end_op>:
80102b80:	55                   	push   %ebp
80102b81:	89 e5                	mov    %esp,%ebp
80102b83:	57                   	push   %edi
80102b84:	56                   	push   %esi
80102b85:	53                   	push   %ebx
80102b86:	83 ec 1c             	sub    $0x1c,%esp
80102b89:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102b90:	e8 3b 19 00 00       	call   801044d0 <acquire>
80102b95:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102b9a:	8b 15 c0 26 11 80    	mov    0x801126c0,%edx
80102ba0:	83 e8 01             	sub    $0x1,%eax
80102ba3:	85 d2                	test   %edx,%edx
80102ba5:	a3 bc 26 11 80       	mov    %eax,0x801126bc
80102baa:	0f 85 f3 00 00 00    	jne    80102ca3 <end_op+0x123>
80102bb0:	85 c0                	test   %eax,%eax
80102bb2:	0f 85 cb 00 00 00    	jne    80102c83 <end_op+0x103>
80102bb8:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102bbf:	31 db                	xor    %ebx,%ebx
80102bc1:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102bc8:	00 00 00 
80102bcb:	e8 70 19 00 00       	call   80104540 <release>
80102bd0:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102bd5:	85 c0                	test   %eax,%eax
80102bd7:	0f 8e 90 00 00 00    	jle    80102c6d <end_op+0xed>
80102bdd:	8d 76 00             	lea    0x0(%esi),%esi
80102be0:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102be5:	01 d8                	add    %ebx,%eax
80102be7:	83 c0 01             	add    $0x1,%eax
80102bea:	89 44 24 04          	mov    %eax,0x4(%esp)
80102bee:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102bf3:	89 04 24             	mov    %eax,(%esp)
80102bf6:	e8 d5 d4 ff ff       	call   801000d0 <bread>
80102bfb:	89 c6                	mov    %eax,%esi
80102bfd:	8b 04 9d cc 26 11 80 	mov    -0x7feed934(,%ebx,4),%eax
80102c04:	83 c3 01             	add    $0x1,%ebx
80102c07:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c0b:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102c10:	89 04 24             	mov    %eax,(%esp)
80102c13:	e8 b8 d4 ff ff       	call   801000d0 <bread>
80102c18:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102c1f:	00 
80102c20:	89 c7                	mov    %eax,%edi
80102c22:	8d 40 5c             	lea    0x5c(%eax),%eax
80102c25:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c29:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c2c:	89 04 24             	mov    %eax,(%esp)
80102c2f:	e8 fc 19 00 00       	call   80104630 <memmove>
80102c34:	89 34 24             	mov    %esi,(%esp)
80102c37:	e8 64 d5 ff ff       	call   801001a0 <bwrite>
80102c3c:	89 3c 24             	mov    %edi,(%esp)
80102c3f:	e8 9c d5 ff ff       	call   801001e0 <brelse>
80102c44:	89 34 24             	mov    %esi,(%esp)
80102c47:	e8 94 d5 ff ff       	call   801001e0 <brelse>
80102c4c:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102c52:	7c 8c                	jl     80102be0 <end_op+0x60>
80102c54:	e8 a7 fd ff ff       	call   80102a00 <write_head>
80102c59:	e8 02 fd ff ff       	call   80102960 <install_trans>
80102c5e:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102c65:	00 00 00 
80102c68:	e8 93 fd ff ff       	call   80102a00 <write_head>
80102c6d:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102c74:	e8 57 18 00 00       	call   801044d0 <acquire>
80102c79:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102c80:	00 00 00 
80102c83:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102c8a:	e8 c1 13 00 00       	call   80104050 <wakeup>
80102c8f:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102c96:	e8 a5 18 00 00       	call   80104540 <release>
80102c9b:	83 c4 1c             	add    $0x1c,%esp
80102c9e:	5b                   	pop    %ebx
80102c9f:	5e                   	pop    %esi
80102ca0:	5f                   	pop    %edi
80102ca1:	5d                   	pop    %ebp
80102ca2:	c3                   	ret    
80102ca3:	c7 04 24 c4 74 10 80 	movl   $0x801074c4,(%esp)
80102caa:	e8 b1 d6 ff ff       	call   80100360 <panic>
80102caf:	90                   	nop

80102cb0 <log_write>:
80102cb0:	55                   	push   %ebp
80102cb1:	89 e5                	mov    %esp,%ebp
80102cb3:	53                   	push   %ebx
80102cb4:	83 ec 14             	sub    $0x14,%esp
80102cb7:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102cbc:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102cbf:	83 f8 1d             	cmp    $0x1d,%eax
80102cc2:	0f 8f 98 00 00 00    	jg     80102d60 <log_write+0xb0>
80102cc8:	8b 0d b8 26 11 80    	mov    0x801126b8,%ecx
80102cce:	8d 51 ff             	lea    -0x1(%ecx),%edx
80102cd1:	39 d0                	cmp    %edx,%eax
80102cd3:	0f 8d 87 00 00 00    	jge    80102d60 <log_write+0xb0>
80102cd9:	a1 bc 26 11 80       	mov    0x801126bc,%eax
80102cde:	85 c0                	test   %eax,%eax
80102ce0:	0f 8e 86 00 00 00    	jle    80102d6c <log_write+0xbc>
80102ce6:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102ced:	e8 de 17 00 00       	call   801044d0 <acquire>
80102cf2:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102cf8:	83 fa 00             	cmp    $0x0,%edx
80102cfb:	7e 54                	jle    80102d51 <log_write+0xa1>
80102cfd:	8b 4b 08             	mov    0x8(%ebx),%ecx
80102d00:	31 c0                	xor    %eax,%eax
80102d02:	39 0d cc 26 11 80    	cmp    %ecx,0x801126cc
80102d08:	75 0f                	jne    80102d19 <log_write+0x69>
80102d0a:	eb 3c                	jmp    80102d48 <log_write+0x98>
80102d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d10:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
80102d17:	74 2f                	je     80102d48 <log_write+0x98>
80102d19:	83 c0 01             	add    $0x1,%eax
80102d1c:	39 d0                	cmp    %edx,%eax
80102d1e:	75 f0                	jne    80102d10 <log_write+0x60>
80102d20:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
80102d27:	83 c2 01             	add    $0x1,%edx
80102d2a:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
80102d30:	83 0b 04             	orl    $0x4,(%ebx)
80102d33:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
80102d3a:	83 c4 14             	add    $0x14,%esp
80102d3d:	5b                   	pop    %ebx
80102d3e:	5d                   	pop    %ebp
80102d3f:	e9 fc 17 00 00       	jmp    80104540 <release>
80102d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d48:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
80102d4f:	eb df                	jmp    80102d30 <log_write+0x80>
80102d51:	8b 43 08             	mov    0x8(%ebx),%eax
80102d54:	a3 cc 26 11 80       	mov    %eax,0x801126cc
80102d59:	75 d5                	jne    80102d30 <log_write+0x80>
80102d5b:	eb ca                	jmp    80102d27 <log_write+0x77>
80102d5d:	8d 76 00             	lea    0x0(%esi),%esi
80102d60:	c7 04 24 d3 74 10 80 	movl   $0x801074d3,(%esp)
80102d67:	e8 f4 d5 ff ff       	call   80100360 <panic>
80102d6c:	c7 04 24 e9 74 10 80 	movl   $0x801074e9,(%esp)
80102d73:	e8 e8 d5 ff ff       	call   80100360 <panic>
80102d78:	66 90                	xchg   %ax,%ax
80102d7a:	66 90                	xchg   %ax,%ax
80102d7c:	66 90                	xchg   %ax,%ax
80102d7e:	66 90                	xchg   %ax,%ax

80102d80 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102d80:	55                   	push   %ebp
80102d81:	89 e5                	mov    %esp,%ebp
80102d83:	53                   	push   %ebx
80102d84:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102d87:	e8 44 09 00 00       	call   801036d0 <cpuid>
80102d8c:	89 c3                	mov    %eax,%ebx
80102d8e:	e8 3d 09 00 00       	call   801036d0 <cpuid>
80102d93:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102d97:	c7 04 24 04 75 10 80 	movl   $0x80107504,(%esp)
80102d9e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102da2:	e8 a9 d8 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80102da7:	e8 f4 2a 00 00       	call   801058a0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102dac:	e8 9f 08 00 00       	call   80103650 <mycpu>
80102db1:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102db3:	b8 01 00 00 00       	mov    $0x1,%eax
80102db8:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102dbf:	e8 ec 0b 00 00       	call   801039b0 <scheduler>
80102dc4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102dca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102dd0 <mpenter>:
{
80102dd0:	55                   	push   %ebp
80102dd1:	89 e5                	mov    %esp,%ebp
80102dd3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102dd6:	e8 95 3b 00 00       	call   80106970 <switchkvm>
  seginit();
80102ddb:	e8 d0 3a 00 00       	call   801068b0 <seginit>
  lapicinit();
80102de0:	e8 8b f8 ff ff       	call   80102670 <lapicinit>
  mpmain();
80102de5:	e8 96 ff ff ff       	call   80102d80 <mpmain>
80102dea:	66 90                	xchg   %ax,%ax
80102dec:	66 90                	xchg   %ax,%ax
80102dee:	66 90                	xchg   %ax,%ax

80102df0 <main>:
{
80102df0:	55                   	push   %ebp
80102df1:	89 e5                	mov    %esp,%ebp
80102df3:	53                   	push   %ebx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102df4:	bb 80 27 11 80       	mov    $0x80112780,%ebx
{
80102df9:	83 e4 f0             	and    $0xfffffff0,%esp
80102dfc:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102dff:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80102e06:	80 
80102e07:	c7 04 24 a8 58 11 80 	movl   $0x801158a8,(%esp)
80102e0e:	e8 cd f5 ff ff       	call   801023e0 <kinit1>
  kvmalloc();      // kernel page table
80102e13:	e8 e8 3f 00 00       	call   80106e00 <kvmalloc>
  mpinit();        // detect other processors
80102e18:	e8 73 01 00 00       	call   80102f90 <mpinit>
80102e1d:	8d 76 00             	lea    0x0(%esi),%esi
  lapicinit();     // interrupt controller
80102e20:	e8 4b f8 ff ff       	call   80102670 <lapicinit>
  seginit();       // segment descriptors
80102e25:	e8 86 3a 00 00       	call   801068b0 <seginit>
  picinit();       // disable pic
80102e2a:	e8 21 03 00 00       	call   80103150 <picinit>
80102e2f:	90                   	nop
  ioapicinit();    // another interrupt controller
80102e30:	e8 cb f3 ff ff       	call   80102200 <ioapicinit>
  consoleinit();   // console hardware
80102e35:	e8 16 db ff ff       	call   80100950 <consoleinit>
  uartinit();      // serial port
80102e3a:	e8 91 2d 00 00       	call   80105bd0 <uartinit>
80102e3f:	90                   	nop
  pinit();         // process table
80102e40:	e8 eb 07 00 00       	call   80103630 <pinit>
  tvinit();        // trap vectors
80102e45:	e8 b6 29 00 00       	call   80105800 <tvinit>
  binit();         // buffer cache
80102e4a:	e8 f1 d1 ff ff       	call   80100040 <binit>
80102e4f:	90                   	nop
  fileinit();      // file table
80102e50:	e8 fb de ff ff       	call   80100d50 <fileinit>
  ideinit();       // disk 
80102e55:	e8 a6 f1 ff ff       	call   80102000 <ideinit>
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102e5a:	c7 44 24 08 8a 00 00 	movl   $0x8a,0x8(%esp)
80102e61:	00 
80102e62:	c7 44 24 04 8c a4 10 	movl   $0x8010a48c,0x4(%esp)
80102e69:	80 
80102e6a:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102e71:	e8 ba 17 00 00       	call   80104630 <memmove>
  for(c = cpus; c < cpus+ncpu; c++){
80102e76:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102e7d:	00 00 00 
80102e80:	05 80 27 11 80       	add    $0x80112780,%eax
80102e85:	39 d8                	cmp    %ebx,%eax
80102e87:	76 6a                	jbe    80102ef3 <main+0x103>
80102e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80102e90:	e8 bb 07 00 00       	call   80103650 <mycpu>
80102e95:	39 d8                	cmp    %ebx,%eax
80102e97:	74 41                	je     80102eda <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102e99:	e8 02 f6 ff ff       	call   801024a0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
80102e9e:	c7 05 f8 6f 00 80 d0 	movl   $0x80102dd0,0x80006ff8
80102ea5:	2d 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102ea8:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102eaf:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102eb2:	05 00 10 00 00       	add    $0x1000,%eax
80102eb7:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102ebc:	0f b6 03             	movzbl (%ebx),%eax
80102ebf:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
80102ec6:	00 
80102ec7:	89 04 24             	mov    %eax,(%esp)
80102eca:	e8 e1 f8 ff ff       	call   801027b0 <lapicstartap>
80102ecf:	90                   	nop

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102ed0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102ed6:	85 c0                	test   %eax,%eax
80102ed8:	74 f6                	je     80102ed0 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102eda:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102ee1:	00 00 00 
80102ee4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102eea:	05 80 27 11 80       	add    $0x80112780,%eax
80102eef:	39 c3                	cmp    %eax,%ebx
80102ef1:	72 9d                	jb     80102e90 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102ef3:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
80102efa:	8e 
80102efb:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80102f02:	e8 49 f5 ff ff       	call   80102450 <kinit2>
  userinit();      // first user process
80102f07:	e8 14 08 00 00       	call   80103720 <userinit>
  mpmain();        // finish this processor's setup
80102f0c:	e8 6f fe ff ff       	call   80102d80 <mpmain>
80102f11:	66 90                	xchg   %ax,%ax
80102f13:	66 90                	xchg   %ax,%ax
80102f15:	66 90                	xchg   %ax,%ax
80102f17:	66 90                	xchg   %ax,%ax
80102f19:	66 90                	xchg   %ax,%ax
80102f1b:	66 90                	xchg   %ax,%ax
80102f1d:	66 90                	xchg   %ax,%ax
80102f1f:	90                   	nop

80102f20 <mpsearch1>:
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	56                   	push   %esi
80102f24:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
80102f2a:	53                   	push   %ebx
80102f2b:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
80102f2e:	83 ec 10             	sub    $0x10,%esp
80102f31:	39 de                	cmp    %ebx,%esi
80102f33:	73 3c                	jae    80102f71 <mpsearch1+0x51>
80102f35:	8d 76 00             	lea    0x0(%esi),%esi
80102f38:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80102f3f:	00 
80102f40:	c7 44 24 04 18 75 10 	movl   $0x80107518,0x4(%esp)
80102f47:	80 
80102f48:	89 34 24             	mov    %esi,(%esp)
80102f4b:	e8 90 16 00 00       	call   801045e0 <memcmp>
80102f50:	85 c0                	test   %eax,%eax
80102f52:	75 16                	jne    80102f6a <mpsearch1+0x4a>
80102f54:	31 c9                	xor    %ecx,%ecx
80102f56:	31 d2                	xor    %edx,%edx
80102f58:	0f b6 04 16          	movzbl (%esi,%edx,1),%eax
80102f5c:	83 c2 01             	add    $0x1,%edx
80102f5f:	01 c1                	add    %eax,%ecx
80102f61:	83 fa 10             	cmp    $0x10,%edx
80102f64:	75 f2                	jne    80102f58 <mpsearch1+0x38>
80102f66:	84 c9                	test   %cl,%cl
80102f68:	74 10                	je     80102f7a <mpsearch1+0x5a>
80102f6a:	83 c6 10             	add    $0x10,%esi
80102f6d:	39 f3                	cmp    %esi,%ebx
80102f6f:	77 c7                	ja     80102f38 <mpsearch1+0x18>
80102f71:	83 c4 10             	add    $0x10,%esp
80102f74:	31 c0                	xor    %eax,%eax
80102f76:	5b                   	pop    %ebx
80102f77:	5e                   	pop    %esi
80102f78:	5d                   	pop    %ebp
80102f79:	c3                   	ret    
80102f7a:	83 c4 10             	add    $0x10,%esp
80102f7d:	89 f0                	mov    %esi,%eax
80102f7f:	5b                   	pop    %ebx
80102f80:	5e                   	pop    %esi
80102f81:	5d                   	pop    %ebp
80102f82:	c3                   	ret    
80102f83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102f89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f90 <mpinit>:
80102f90:	55                   	push   %ebp
80102f91:	89 e5                	mov    %esp,%ebp
80102f93:	57                   	push   %edi
80102f94:	56                   	push   %esi
80102f95:	53                   	push   %ebx
80102f96:	83 ec 1c             	sub    $0x1c,%esp
80102f99:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80102fa0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80102fa7:	c1 e0 08             	shl    $0x8,%eax
80102faa:	09 d0                	or     %edx,%eax
80102fac:	c1 e0 04             	shl    $0x4,%eax
80102faf:	85 c0                	test   %eax,%eax
80102fb1:	75 1b                	jne    80102fce <mpinit+0x3e>
80102fb3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80102fba:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80102fc1:	c1 e0 08             	shl    $0x8,%eax
80102fc4:	09 d0                	or     %edx,%eax
80102fc6:	c1 e0 0a             	shl    $0xa,%eax
80102fc9:	2d 00 04 00 00       	sub    $0x400,%eax
80102fce:	ba 00 04 00 00       	mov    $0x400,%edx
80102fd3:	e8 48 ff ff ff       	call   80102f20 <mpsearch1>
80102fd8:	85 c0                	test   %eax,%eax
80102fda:	89 c7                	mov    %eax,%edi
80102fdc:	0f 84 22 01 00 00    	je     80103104 <mpinit+0x174>
80102fe2:	8b 77 04             	mov    0x4(%edi),%esi
80102fe5:	85 f6                	test   %esi,%esi
80102fe7:	0f 84 30 01 00 00    	je     8010311d <mpinit+0x18d>
80102fed:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80102ff3:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80102ffa:	00 
80102ffb:	c7 44 24 04 1d 75 10 	movl   $0x8010751d,0x4(%esp)
80103002:	80 
80103003:	89 04 24             	mov    %eax,(%esp)
80103006:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103009:	e8 d2 15 00 00       	call   801045e0 <memcmp>
8010300e:	85 c0                	test   %eax,%eax
80103010:	0f 85 07 01 00 00    	jne    8010311d <mpinit+0x18d>
80103016:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
8010301d:	3c 04                	cmp    $0x4,%al
8010301f:	0f 85 0b 01 00 00    	jne    80103130 <mpinit+0x1a0>
80103025:	0f b7 86 04 00 00 80 	movzwl -0x7ffffffc(%esi),%eax
8010302c:	85 c0                	test   %eax,%eax
8010302e:	74 21                	je     80103051 <mpinit+0xc1>
80103030:	31 c9                	xor    %ecx,%ecx
80103032:	31 d2                	xor    %edx,%edx
80103034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103038:	0f b6 9c 16 00 00 00 	movzbl -0x80000000(%esi,%edx,1),%ebx
8010303f:	80 
80103040:	83 c2 01             	add    $0x1,%edx
80103043:	01 d9                	add    %ebx,%ecx
80103045:	39 d0                	cmp    %edx,%eax
80103047:	7f ef                	jg     80103038 <mpinit+0xa8>
80103049:	84 c9                	test   %cl,%cl
8010304b:	0f 85 cc 00 00 00    	jne    8010311d <mpinit+0x18d>
80103051:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103054:	85 c0                	test   %eax,%eax
80103056:	0f 84 c1 00 00 00    	je     8010311d <mpinit+0x18d>
8010305c:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
80103062:	bb 01 00 00 00       	mov    $0x1,%ebx
80103067:	a3 7c 26 11 80       	mov    %eax,0x8011267c
8010306c:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103073:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80103079:	03 55 e4             	add    -0x1c(%ebp),%edx
8010307c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103080:	39 c2                	cmp    %eax,%edx
80103082:	76 1b                	jbe    8010309f <mpinit+0x10f>
80103084:	0f b6 08             	movzbl (%eax),%ecx
80103087:	80 f9 04             	cmp    $0x4,%cl
8010308a:	77 74                	ja     80103100 <mpinit+0x170>
8010308c:	ff 24 8d 5c 75 10 80 	jmp    *-0x7fef8aa4(,%ecx,4)
80103093:	90                   	nop
80103094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103098:	83 c0 08             	add    $0x8,%eax
8010309b:	39 c2                	cmp    %eax,%edx
8010309d:	77 e5                	ja     80103084 <mpinit+0xf4>
8010309f:	85 db                	test   %ebx,%ebx
801030a1:	0f 84 93 00 00 00    	je     8010313a <mpinit+0x1aa>
801030a7:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
801030ab:	74 12                	je     801030bf <mpinit+0x12f>
801030ad:	ba 22 00 00 00       	mov    $0x22,%edx
801030b2:	b8 70 00 00 00       	mov    $0x70,%eax
801030b7:	ee                   	out    %al,(%dx)
801030b8:	b2 23                	mov    $0x23,%dl
801030ba:	ec                   	in     (%dx),%al
801030bb:	83 c8 01             	or     $0x1,%eax
801030be:	ee                   	out    %al,(%dx)
801030bf:	83 c4 1c             	add    $0x1c,%esp
801030c2:	5b                   	pop    %ebx
801030c3:	5e                   	pop    %esi
801030c4:	5f                   	pop    %edi
801030c5:	5d                   	pop    %ebp
801030c6:	c3                   	ret    
801030c7:	90                   	nop
801030c8:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
801030ce:	83 fe 07             	cmp    $0x7,%esi
801030d1:	7f 17                	jg     801030ea <mpinit+0x15a>
801030d3:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
801030d7:	69 f6 b0 00 00 00    	imul   $0xb0,%esi,%esi
801030dd:	83 05 00 2d 11 80 01 	addl   $0x1,0x80112d00
801030e4:	88 8e 80 27 11 80    	mov    %cl,-0x7feed880(%esi)
801030ea:	83 c0 14             	add    $0x14,%eax
801030ed:	eb 91                	jmp    80103080 <mpinit+0xf0>
801030ef:	90                   	nop
801030f0:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
801030f4:	83 c0 08             	add    $0x8,%eax
801030f7:	88 0d 60 27 11 80    	mov    %cl,0x80112760
801030fd:	eb 81                	jmp    80103080 <mpinit+0xf0>
801030ff:	90                   	nop
80103100:	31 db                	xor    %ebx,%ebx
80103102:	eb 83                	jmp    80103087 <mpinit+0xf7>
80103104:	ba 00 00 01 00       	mov    $0x10000,%edx
80103109:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010310e:	e8 0d fe ff ff       	call   80102f20 <mpsearch1>
80103113:	85 c0                	test   %eax,%eax
80103115:	89 c7                	mov    %eax,%edi
80103117:	0f 85 c5 fe ff ff    	jne    80102fe2 <mpinit+0x52>
8010311d:	c7 04 24 22 75 10 80 	movl   $0x80107522,(%esp)
80103124:	e8 37 d2 ff ff       	call   80100360 <panic>
80103129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103130:	3c 01                	cmp    $0x1,%al
80103132:	0f 84 ed fe ff ff    	je     80103025 <mpinit+0x95>
80103138:	eb e3                	jmp    8010311d <mpinit+0x18d>
8010313a:	c7 04 24 3c 75 10 80 	movl   $0x8010753c,(%esp)
80103141:	e8 1a d2 ff ff       	call   80100360 <panic>
80103146:	66 90                	xchg   %ax,%ax
80103148:	66 90                	xchg   %ax,%ax
8010314a:	66 90                	xchg   %ax,%ax
8010314c:	66 90                	xchg   %ax,%ax
8010314e:	66 90                	xchg   %ax,%ax

80103150 <picinit>:
80103150:	55                   	push   %ebp
80103151:	ba 21 00 00 00       	mov    $0x21,%edx
80103156:	89 e5                	mov    %esp,%ebp
80103158:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010315d:	ee                   	out    %al,(%dx)
8010315e:	b2 a1                	mov    $0xa1,%dl
80103160:	ee                   	out    %al,(%dx)
80103161:	5d                   	pop    %ebp
80103162:	c3                   	ret    
80103163:	66 90                	xchg   %ax,%ax
80103165:	66 90                	xchg   %ax,%ax
80103167:	66 90                	xchg   %ax,%ax
80103169:	66 90                	xchg   %ax,%ax
8010316b:	66 90                	xchg   %ax,%ax
8010316d:	66 90                	xchg   %ax,%ax
8010316f:	90                   	nop

80103170 <pipealloc>:
80103170:	55                   	push   %ebp
80103171:	89 e5                	mov    %esp,%ebp
80103173:	57                   	push   %edi
80103174:	56                   	push   %esi
80103175:	53                   	push   %ebx
80103176:	83 ec 1c             	sub    $0x1c,%esp
80103179:	8b 75 08             	mov    0x8(%ebp),%esi
8010317c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010317f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103185:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010318b:	e8 e0 db ff ff       	call   80100d70 <filealloc>
80103190:	85 c0                	test   %eax,%eax
80103192:	89 06                	mov    %eax,(%esi)
80103194:	0f 84 a4 00 00 00    	je     8010323e <pipealloc+0xce>
8010319a:	e8 d1 db ff ff       	call   80100d70 <filealloc>
8010319f:	85 c0                	test   %eax,%eax
801031a1:	89 03                	mov    %eax,(%ebx)
801031a3:	0f 84 87 00 00 00    	je     80103230 <pipealloc+0xc0>
801031a9:	e8 f2 f2 ff ff       	call   801024a0 <kalloc>
801031ae:	85 c0                	test   %eax,%eax
801031b0:	89 c7                	mov    %eax,%edi
801031b2:	74 7c                	je     80103230 <pipealloc+0xc0>
801031b4:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801031bb:	00 00 00 
801031be:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801031c5:	00 00 00 
801031c8:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801031cf:	00 00 00 
801031d2:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801031d9:	00 00 00 
801031dc:	89 04 24             	mov    %eax,(%esp)
801031df:	c7 44 24 04 70 75 10 	movl   $0x80107570,0x4(%esp)
801031e6:	80 
801031e7:	e8 74 11 00 00       	call   80104360 <initlock>
801031ec:	8b 06                	mov    (%esi),%eax
801031ee:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
801031f4:	8b 06                	mov    (%esi),%eax
801031f6:	c6 40 08 01          	movb   $0x1,0x8(%eax)
801031fa:	8b 06                	mov    (%esi),%eax
801031fc:	c6 40 09 00          	movb   $0x0,0x9(%eax)
80103200:	8b 06                	mov    (%esi),%eax
80103202:	89 78 0c             	mov    %edi,0xc(%eax)
80103205:	8b 03                	mov    (%ebx),%eax
80103207:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
8010320d:	8b 03                	mov    (%ebx),%eax
8010320f:	c6 40 08 00          	movb   $0x0,0x8(%eax)
80103213:	8b 03                	mov    (%ebx),%eax
80103215:	c6 40 09 01          	movb   $0x1,0x9(%eax)
80103219:	8b 03                	mov    (%ebx),%eax
8010321b:	31 db                	xor    %ebx,%ebx
8010321d:	89 78 0c             	mov    %edi,0xc(%eax)
80103220:	83 c4 1c             	add    $0x1c,%esp
80103223:	89 d8                	mov    %ebx,%eax
80103225:	5b                   	pop    %ebx
80103226:	5e                   	pop    %esi
80103227:	5f                   	pop    %edi
80103228:	5d                   	pop    %ebp
80103229:	c3                   	ret    
8010322a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103230:	8b 06                	mov    (%esi),%eax
80103232:	85 c0                	test   %eax,%eax
80103234:	74 08                	je     8010323e <pipealloc+0xce>
80103236:	89 04 24             	mov    %eax,(%esp)
80103239:	e8 f2 db ff ff       	call   80100e30 <fileclose>
8010323e:	8b 03                	mov    (%ebx),%eax
80103240:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103245:	85 c0                	test   %eax,%eax
80103247:	74 d7                	je     80103220 <pipealloc+0xb0>
80103249:	89 04 24             	mov    %eax,(%esp)
8010324c:	e8 df db ff ff       	call   80100e30 <fileclose>
80103251:	83 c4 1c             	add    $0x1c,%esp
80103254:	89 d8                	mov    %ebx,%eax
80103256:	5b                   	pop    %ebx
80103257:	5e                   	pop    %esi
80103258:	5f                   	pop    %edi
80103259:	5d                   	pop    %ebp
8010325a:	c3                   	ret    
8010325b:	90                   	nop
8010325c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103260 <pipeclose>:
80103260:	55                   	push   %ebp
80103261:	89 e5                	mov    %esp,%ebp
80103263:	56                   	push   %esi
80103264:	53                   	push   %ebx
80103265:	83 ec 10             	sub    $0x10,%esp
80103268:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010326b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010326e:	89 1c 24             	mov    %ebx,(%esp)
80103271:	e8 5a 12 00 00       	call   801044d0 <acquire>
80103276:	85 f6                	test   %esi,%esi
80103278:	74 3e                	je     801032b8 <pipeclose+0x58>
8010327a:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103280:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103287:	00 00 00 
8010328a:	89 04 24             	mov    %eax,(%esp)
8010328d:	e8 be 0d 00 00       	call   80104050 <wakeup>
80103292:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103298:	85 d2                	test   %edx,%edx
8010329a:	75 0a                	jne    801032a6 <pipeclose+0x46>
8010329c:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801032a2:	85 c0                	test   %eax,%eax
801032a4:	74 32                	je     801032d8 <pipeclose+0x78>
801032a6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801032a9:	83 c4 10             	add    $0x10,%esp
801032ac:	5b                   	pop    %ebx
801032ad:	5e                   	pop    %esi
801032ae:	5d                   	pop    %ebp
801032af:	e9 8c 12 00 00       	jmp    80104540 <release>
801032b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801032b8:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801032be:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801032c5:	00 00 00 
801032c8:	89 04 24             	mov    %eax,(%esp)
801032cb:	e8 80 0d 00 00       	call   80104050 <wakeup>
801032d0:	eb c0                	jmp    80103292 <pipeclose+0x32>
801032d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801032d8:	89 1c 24             	mov    %ebx,(%esp)
801032db:	e8 60 12 00 00       	call   80104540 <release>
801032e0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801032e3:	83 c4 10             	add    $0x10,%esp
801032e6:	5b                   	pop    %ebx
801032e7:	5e                   	pop    %esi
801032e8:	5d                   	pop    %ebp
801032e9:	e9 02 f0 ff ff       	jmp    801022f0 <kfree>
801032ee:	66 90                	xchg   %ax,%ax

801032f0 <pipewrite>:
801032f0:	55                   	push   %ebp
801032f1:	89 e5                	mov    %esp,%ebp
801032f3:	57                   	push   %edi
801032f4:	56                   	push   %esi
801032f5:	53                   	push   %ebx
801032f6:	83 ec 1c             	sub    $0x1c,%esp
801032f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801032fc:	89 1c 24             	mov    %ebx,(%esp)
801032ff:	e8 cc 11 00 00       	call   801044d0 <acquire>
80103304:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103307:	85 c9                	test   %ecx,%ecx
80103309:	0f 8e b2 00 00 00    	jle    801033c1 <pipewrite+0xd1>
8010330f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103312:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103318:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
8010331e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103324:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103327:	03 4d 10             	add    0x10(%ebp),%ecx
8010332a:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010332d:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103333:	81 c1 00 02 00 00    	add    $0x200,%ecx
80103339:	39 c8                	cmp    %ecx,%eax
8010333b:	74 38                	je     80103375 <pipewrite+0x85>
8010333d:	eb 55                	jmp    80103394 <pipewrite+0xa4>
8010333f:	90                   	nop
80103340:	e8 ab 03 00 00       	call   801036f0 <myproc>
80103345:	8b 40 24             	mov    0x24(%eax),%eax
80103348:	85 c0                	test   %eax,%eax
8010334a:	75 33                	jne    8010337f <pipewrite+0x8f>
8010334c:	89 3c 24             	mov    %edi,(%esp)
8010334f:	e8 fc 0c 00 00       	call   80104050 <wakeup>
80103354:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103358:	89 34 24             	mov    %esi,(%esp)
8010335b:	e8 40 0a 00 00       	call   80103da0 <sleep>
80103360:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103366:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010336c:	05 00 02 00 00       	add    $0x200,%eax
80103371:	39 c2                	cmp    %eax,%edx
80103373:	75 23                	jne    80103398 <pipewrite+0xa8>
80103375:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010337b:	85 d2                	test   %edx,%edx
8010337d:	75 c1                	jne    80103340 <pipewrite+0x50>
8010337f:	89 1c 24             	mov    %ebx,(%esp)
80103382:	e8 b9 11 00 00       	call   80104540 <release>
80103387:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010338c:	83 c4 1c             	add    $0x1c,%esp
8010338f:	5b                   	pop    %ebx
80103390:	5e                   	pop    %esi
80103391:	5f                   	pop    %edi
80103392:	5d                   	pop    %ebp
80103393:	c3                   	ret    
80103394:	89 c2                	mov    %eax,%edx
80103396:	66 90                	xchg   %ax,%ax
80103398:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010339b:	8d 42 01             	lea    0x1(%edx),%eax
8010339e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801033a4:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801033aa:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801033ae:	0f b6 09             	movzbl (%ecx),%ecx
801033b1:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
801033b5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801033b8:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
801033bb:	0f 85 6c ff ff ff    	jne    8010332d <pipewrite+0x3d>
801033c1:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801033c7:	89 04 24             	mov    %eax,(%esp)
801033ca:	e8 81 0c 00 00       	call   80104050 <wakeup>
801033cf:	89 1c 24             	mov    %ebx,(%esp)
801033d2:	e8 69 11 00 00       	call   80104540 <release>
801033d7:	8b 45 10             	mov    0x10(%ebp),%eax
801033da:	eb b0                	jmp    8010338c <pipewrite+0x9c>
801033dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801033e0 <piperead>:
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	57                   	push   %edi
801033e4:	56                   	push   %esi
801033e5:	53                   	push   %ebx
801033e6:	83 ec 1c             	sub    $0x1c,%esp
801033e9:	8b 75 08             	mov    0x8(%ebp),%esi
801033ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
801033ef:	89 34 24             	mov    %esi,(%esp)
801033f2:	e8 d9 10 00 00       	call   801044d0 <acquire>
801033f7:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801033fd:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103403:	75 5b                	jne    80103460 <piperead+0x80>
80103405:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010340b:	85 db                	test   %ebx,%ebx
8010340d:	74 51                	je     80103460 <piperead+0x80>
8010340f:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103415:	eb 25                	jmp    8010343c <piperead+0x5c>
80103417:	90                   	nop
80103418:	89 74 24 04          	mov    %esi,0x4(%esp)
8010341c:	89 1c 24             	mov    %ebx,(%esp)
8010341f:	e8 7c 09 00 00       	call   80103da0 <sleep>
80103424:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
8010342a:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103430:	75 2e                	jne    80103460 <piperead+0x80>
80103432:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103438:	85 d2                	test   %edx,%edx
8010343a:	74 24                	je     80103460 <piperead+0x80>
8010343c:	e8 af 02 00 00       	call   801036f0 <myproc>
80103441:	8b 48 24             	mov    0x24(%eax),%ecx
80103444:	85 c9                	test   %ecx,%ecx
80103446:	74 d0                	je     80103418 <piperead+0x38>
80103448:	89 34 24             	mov    %esi,(%esp)
8010344b:	e8 f0 10 00 00       	call   80104540 <release>
80103450:	83 c4 1c             	add    $0x1c,%esp
80103453:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103458:	5b                   	pop    %ebx
80103459:	5e                   	pop    %esi
8010345a:	5f                   	pop    %edi
8010345b:	5d                   	pop    %ebp
8010345c:	c3                   	ret    
8010345d:	8d 76 00             	lea    0x0(%esi),%esi
80103460:	8b 55 10             	mov    0x10(%ebp),%edx
80103463:	31 db                	xor    %ebx,%ebx
80103465:	85 d2                	test   %edx,%edx
80103467:	7f 2b                	jg     80103494 <piperead+0xb4>
80103469:	eb 31                	jmp    8010349c <piperead+0xbc>
8010346b:	90                   	nop
8010346c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103470:	8d 48 01             	lea    0x1(%eax),%ecx
80103473:	25 ff 01 00 00       	and    $0x1ff,%eax
80103478:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010347e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103483:	88 04 1f             	mov    %al,(%edi,%ebx,1)
80103486:	83 c3 01             	add    $0x1,%ebx
80103489:	3b 5d 10             	cmp    0x10(%ebp),%ebx
8010348c:	74 0e                	je     8010349c <piperead+0xbc>
8010348e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103494:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010349a:	75 d4                	jne    80103470 <piperead+0x90>
8010349c:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801034a2:	89 04 24             	mov    %eax,(%esp)
801034a5:	e8 a6 0b 00 00       	call   80104050 <wakeup>
801034aa:	89 34 24             	mov    %esi,(%esp)
801034ad:	e8 8e 10 00 00       	call   80104540 <release>
801034b2:	83 c4 1c             	add    $0x1c,%esp
801034b5:	89 d8                	mov    %ebx,%eax
801034b7:	5b                   	pop    %ebx
801034b8:	5e                   	pop    %esi
801034b9:	5f                   	pop    %edi
801034ba:	5d                   	pop    %ebp
801034bb:	c3                   	ret    
801034bc:	66 90                	xchg   %ax,%ax
801034be:	66 90                	xchg   %ax,%ax

801034c0 <allocproc>:
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	53                   	push   %ebx
801034c4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
801034c9:	83 ec 14             	sub    $0x14,%esp
801034cc:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801034d3:	e8 f8 0f 00 00       	call   801044d0 <acquire>
801034d8:	eb 18                	jmp    801034f2 <allocproc+0x32>
801034da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801034e0:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
801034e6:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
801034ec:	0f 84 c6 00 00 00    	je     801035b8 <allocproc+0xf8>
801034f2:	8b 43 0c             	mov    0xc(%ebx),%eax
801034f5:	85 c0                	test   %eax,%eax
801034f7:	75 e7                	jne    801034e0 <allocproc+0x20>
801034f9:	a1 04 a0 10 80       	mov    0x8010a004,%eax
801034fe:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103505:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
8010350c:	8d 50 01             	lea    0x1(%eax),%edx
8010350f:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
80103515:	89 43 10             	mov    %eax,0x10(%ebx)
80103518:	e8 23 10 00 00       	call   80104540 <release>
8010351d:	e8 7e ef ff ff       	call   801024a0 <kalloc>
80103522:	85 c0                	test   %eax,%eax
80103524:	89 43 08             	mov    %eax,0x8(%ebx)
80103527:	0f 84 9f 00 00 00    	je     801035cc <allocproc+0x10c>
8010352d:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
80103533:	05 9c 0f 00 00       	add    $0xf9c,%eax
80103538:	89 53 18             	mov    %edx,0x18(%ebx)
8010353b:	c7 40 14 f5 57 10 80 	movl   $0x801057f5,0x14(%eax)
80103542:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80103549:	00 
8010354a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103551:	00 
80103552:	89 04 24             	mov    %eax,(%esp)
80103555:	89 43 1c             	mov    %eax,0x1c(%ebx)
80103558:	e8 33 10 00 00       	call   80104590 <memset>
8010355d:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103560:	c7 40 10 e0 35 10 80 	movl   $0x801035e0,0x10(%eax)
80103567:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010356e:	e8 5d 0f 00 00       	call   801044d0 <acquire>
80103573:	a1 a0 58 11 80       	mov    0x801158a0,%eax
80103578:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010357f:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
80103585:	e8 b6 0f 00 00       	call   80104540 <release>
8010358a:	8b 83 84 00 00 00    	mov    0x84(%ebx),%eax
80103590:	c7 04 24 75 75 10 80 	movl   $0x80107575,(%esp)
80103597:	89 44 24 04          	mov    %eax,0x4(%esp)
8010359b:	e8 b0 d0 ff ff       	call   80100650 <cprintf>
801035a0:	89 d8                	mov    %ebx,%eax
801035a2:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
801035a9:	00 00 00 
801035ac:	83 c4 14             	add    $0x14,%esp
801035af:	5b                   	pop    %ebx
801035b0:	5d                   	pop    %ebp
801035b1:	c3                   	ret    
801035b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801035b8:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801035bf:	e8 7c 0f 00 00       	call   80104540 <release>
801035c4:	83 c4 14             	add    $0x14,%esp
801035c7:	31 c0                	xor    %eax,%eax
801035c9:	5b                   	pop    %ebx
801035ca:	5d                   	pop    %ebp
801035cb:	c3                   	ret    
801035cc:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
801035d3:	eb d7                	jmp    801035ac <allocproc+0xec>
801035d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801035e0 <forkret>:
801035e0:	55                   	push   %ebp
801035e1:	89 e5                	mov    %esp,%ebp
801035e3:	83 ec 18             	sub    $0x18,%esp
801035e6:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801035ed:	e8 4e 0f 00 00       	call   80104540 <release>
801035f2:	a1 00 a0 10 80       	mov    0x8010a000,%eax
801035f7:	85 c0                	test   %eax,%eax
801035f9:	75 05                	jne    80103600 <forkret+0x20>
801035fb:	c9                   	leave  
801035fc:	c3                   	ret    
801035fd:	8d 76 00             	lea    0x0(%esi),%esi
80103600:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103607:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010360e:	00 00 00 
80103611:	e8 5a de ff ff       	call   80101470 <iinit>
80103616:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010361d:	e8 4e f4 ff ff       	call   80102a70 <initlog>
80103622:	c9                   	leave  
80103623:	c3                   	ret    
80103624:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010362a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103630 <pinit>:
80103630:	55                   	push   %ebp
80103631:	89 e5                	mov    %esp,%ebp
80103633:	83 ec 18             	sub    $0x18,%esp
80103636:	c7 44 24 04 85 75 10 	movl   $0x80107585,0x4(%esp)
8010363d:	80 
8010363e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103645:	e8 16 0d 00 00       	call   80104360 <initlock>
8010364a:	c9                   	leave  
8010364b:	c3                   	ret    
8010364c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103650 <mycpu>:
80103650:	55                   	push   %ebp
80103651:	89 e5                	mov    %esp,%ebp
80103653:	56                   	push   %esi
80103654:	53                   	push   %ebx
80103655:	83 ec 10             	sub    $0x10,%esp
80103658:	9c                   	pushf  
80103659:	58                   	pop    %eax
8010365a:	f6 c4 02             	test   $0x2,%ah
8010365d:	75 57                	jne    801036b6 <mycpu+0x66>
8010365f:	e8 fc f0 ff ff       	call   80102760 <lapicid>
80103664:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
8010366a:	85 f6                	test   %esi,%esi
8010366c:	7e 3c                	jle    801036aa <mycpu+0x5a>
8010366e:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103675:	39 c2                	cmp    %eax,%edx
80103677:	74 2d                	je     801036a6 <mycpu+0x56>
80103679:	b9 30 28 11 80       	mov    $0x80112830,%ecx
8010367e:	31 d2                	xor    %edx,%edx
80103680:	83 c2 01             	add    $0x1,%edx
80103683:	39 f2                	cmp    %esi,%edx
80103685:	74 23                	je     801036aa <mycpu+0x5a>
80103687:	0f b6 19             	movzbl (%ecx),%ebx
8010368a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103690:	39 c3                	cmp    %eax,%ebx
80103692:	75 ec                	jne    80103680 <mycpu+0x30>
80103694:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
8010369a:	83 c4 10             	add    $0x10,%esp
8010369d:	5b                   	pop    %ebx
8010369e:	5e                   	pop    %esi
8010369f:	5d                   	pop    %ebp
801036a0:	05 80 27 11 80       	add    $0x80112780,%eax
801036a5:	c3                   	ret    
801036a6:	31 d2                	xor    %edx,%edx
801036a8:	eb ea                	jmp    80103694 <mycpu+0x44>
801036aa:	c7 04 24 8c 75 10 80 	movl   $0x8010758c,(%esp)
801036b1:	e8 aa cc ff ff       	call   80100360 <panic>
801036b6:	c7 04 24 8c 76 10 80 	movl   $0x8010768c,(%esp)
801036bd:	e8 9e cc ff ff       	call   80100360 <panic>
801036c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801036d0 <cpuid>:
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	83 ec 08             	sub    $0x8,%esp
801036d6:	e8 75 ff ff ff       	call   80103650 <mycpu>
801036db:	c9                   	leave  
801036dc:	2d 80 27 11 80       	sub    $0x80112780,%eax
801036e1:	c1 f8 04             	sar    $0x4,%eax
801036e4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
801036ea:	c3                   	ret    
801036eb:	90                   	nop
801036ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801036f0 <myproc>:
801036f0:	55                   	push   %ebp
801036f1:	89 e5                	mov    %esp,%ebp
801036f3:	53                   	push   %ebx
801036f4:	83 ec 04             	sub    $0x4,%esp
801036f7:	e8 e4 0c 00 00       	call   801043e0 <pushcli>
801036fc:	e8 4f ff ff ff       	call   80103650 <mycpu>
80103701:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80103707:	e8 14 0d 00 00       	call   80104420 <popcli>
8010370c:	83 c4 04             	add    $0x4,%esp
8010370f:	89 d8                	mov    %ebx,%eax
80103711:	5b                   	pop    %ebx
80103712:	5d                   	pop    %ebp
80103713:	c3                   	ret    
80103714:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010371a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103720 <userinit>:
80103720:	55                   	push   %ebp
80103721:	89 e5                	mov    %esp,%ebp
80103723:	53                   	push   %ebx
80103724:	83 ec 14             	sub    $0x14,%esp
80103727:	e8 94 fd ff ff       	call   801034c0 <allocproc>
8010372c:	89 c3                	mov    %eax,%ebx
8010372e:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
80103733:	e8 38 36 00 00       	call   80106d70 <setupkvm>
80103738:	85 c0                	test   %eax,%eax
8010373a:	89 43 04             	mov    %eax,0x4(%ebx)
8010373d:	0f 84 d4 00 00 00    	je     80103817 <userinit+0xf7>
80103743:	89 04 24             	mov    %eax,(%esp)
80103746:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
8010374d:	00 
8010374e:	c7 44 24 04 60 a4 10 	movl   $0x8010a460,0x4(%esp)
80103755:	80 
80103756:	e8 45 33 00 00       	call   80106aa0 <inituvm>
8010375b:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
80103761:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
80103768:	00 
80103769:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103770:	00 
80103771:	8b 43 18             	mov    0x18(%ebx),%eax
80103774:	89 04 24             	mov    %eax,(%esp)
80103777:	e8 14 0e 00 00       	call   80104590 <memset>
8010377c:	8b 43 18             	mov    0x18(%ebx),%eax
8010377f:	ba 1b 00 00 00       	mov    $0x1b,%edx
80103784:	b9 23 00 00 00       	mov    $0x23,%ecx
80103789:	66 89 50 3c          	mov    %dx,0x3c(%eax)
8010378d:	8b 43 18             	mov    0x18(%ebx),%eax
80103790:	66 89 48 2c          	mov    %cx,0x2c(%eax)
80103794:	8b 43 18             	mov    0x18(%ebx),%eax
80103797:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010379b:	66 89 50 28          	mov    %dx,0x28(%eax)
8010379f:	8b 43 18             	mov    0x18(%ebx),%eax
801037a2:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801037a6:	66 89 50 48          	mov    %dx,0x48(%eax)
801037aa:	8b 43 18             	mov    0x18(%ebx),%eax
801037ad:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
801037b4:	8b 43 18             	mov    0x18(%ebx),%eax
801037b7:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
801037be:	8b 43 18             	mov    0x18(%ebx),%eax
801037c1:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
801037c8:	8d 43 6c             	lea    0x6c(%ebx),%eax
801037cb:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801037d2:	00 
801037d3:	c7 44 24 04 b5 75 10 	movl   $0x801075b5,0x4(%esp)
801037da:	80 
801037db:	89 04 24             	mov    %eax,(%esp)
801037de:	e8 8d 0f 00 00       	call   80104770 <safestrcpy>
801037e3:	c7 04 24 be 75 10 80 	movl   $0x801075be,(%esp)
801037ea:	e8 11 e7 ff ff       	call   80101f00 <namei>
801037ef:	89 43 68             	mov    %eax,0x68(%ebx)
801037f2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801037f9:	e8 d2 0c 00 00       	call   801044d0 <acquire>
801037fe:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
80103805:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010380c:	e8 2f 0d 00 00       	call   80104540 <release>
80103811:	83 c4 14             	add    $0x14,%esp
80103814:	5b                   	pop    %ebx
80103815:	5d                   	pop    %ebp
80103816:	c3                   	ret    
80103817:	c7 04 24 9c 75 10 80 	movl   $0x8010759c,(%esp)
8010381e:	e8 3d cb ff ff       	call   80100360 <panic>
80103823:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103829:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103830 <growproc>:
80103830:	55                   	push   %ebp
80103831:	89 e5                	mov    %esp,%ebp
80103833:	56                   	push   %esi
80103834:	53                   	push   %ebx
80103835:	83 ec 10             	sub    $0x10,%esp
80103838:	8b 75 08             	mov    0x8(%ebp),%esi
8010383b:	e8 b0 fe ff ff       	call   801036f0 <myproc>
80103840:	83 fe 00             	cmp    $0x0,%esi
80103843:	89 c3                	mov    %eax,%ebx
80103845:	8b 00                	mov    (%eax),%eax
80103847:	7e 2f                	jle    80103878 <growproc+0x48>
80103849:	01 c6                	add    %eax,%esi
8010384b:	89 74 24 08          	mov    %esi,0x8(%esp)
8010384f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103853:	8b 43 04             	mov    0x4(%ebx),%eax
80103856:	89 04 24             	mov    %eax,(%esp)
80103859:	e8 82 33 00 00       	call   80106be0 <allocuvm>
8010385e:	85 c0                	test   %eax,%eax
80103860:	74 36                	je     80103898 <growproc+0x68>
80103862:	89 03                	mov    %eax,(%ebx)
80103864:	89 1c 24             	mov    %ebx,(%esp)
80103867:	e8 24 31 00 00       	call   80106990 <switchuvm>
8010386c:	31 c0                	xor    %eax,%eax
8010386e:	83 c4 10             	add    $0x10,%esp
80103871:	5b                   	pop    %ebx
80103872:	5e                   	pop    %esi
80103873:	5d                   	pop    %ebp
80103874:	c3                   	ret    
80103875:	8d 76 00             	lea    0x0(%esi),%esi
80103878:	74 e8                	je     80103862 <growproc+0x32>
8010387a:	01 c6                	add    %eax,%esi
8010387c:	89 74 24 08          	mov    %esi,0x8(%esp)
80103880:	89 44 24 04          	mov    %eax,0x4(%esp)
80103884:	8b 43 04             	mov    0x4(%ebx),%eax
80103887:	89 04 24             	mov    %eax,(%esp)
8010388a:	e8 41 34 00 00       	call   80106cd0 <deallocuvm>
8010388f:	85 c0                	test   %eax,%eax
80103891:	75 cf                	jne    80103862 <growproc+0x32>
80103893:	90                   	nop
80103894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103898:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010389d:	eb cf                	jmp    8010386e <growproc+0x3e>
8010389f:	90                   	nop

801038a0 <fork>:
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	57                   	push   %edi
801038a4:	56                   	push   %esi
801038a5:	53                   	push   %ebx
801038a6:	83 ec 1c             	sub    $0x1c,%esp
801038a9:	e8 42 fe ff ff       	call   801036f0 <myproc>
801038ae:	89 c3                	mov    %eax,%ebx
801038b0:	e8 0b fc ff ff       	call   801034c0 <allocproc>
801038b5:	85 c0                	test   %eax,%eax
801038b7:	89 c7                	mov    %eax,%edi
801038b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801038bc:	0f 84 c4 00 00 00    	je     80103986 <fork+0xe6>
801038c2:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
801038c8:	89 87 80 00 00 00    	mov    %eax,0x80(%edi)
801038ce:	8b 03                	mov    (%ebx),%eax
801038d0:	89 44 24 04          	mov    %eax,0x4(%esp)
801038d4:	8b 43 04             	mov    0x4(%ebx),%eax
801038d7:	89 04 24             	mov    %eax,(%esp)
801038da:	e8 71 35 00 00       	call   80106e50 <copyuvm>
801038df:	85 c0                	test   %eax,%eax
801038e1:	89 47 04             	mov    %eax,0x4(%edi)
801038e4:	0f 84 a3 00 00 00    	je     8010398d <fork+0xed>
801038ea:	8b 03                	mov    (%ebx),%eax
801038ec:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801038ef:	89 01                	mov    %eax,(%ecx)
801038f1:	8b 79 18             	mov    0x18(%ecx),%edi
801038f4:	89 c8                	mov    %ecx,%eax
801038f6:	89 59 14             	mov    %ebx,0x14(%ecx)
801038f9:	8b 73 18             	mov    0x18(%ebx),%esi
801038fc:	b9 13 00 00 00       	mov    $0x13,%ecx
80103901:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
80103903:	31 f6                	xor    %esi,%esi
80103905:	8b 40 18             	mov    0x18(%eax),%eax
80103908:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
8010390f:	90                   	nop
80103910:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103914:	85 c0                	test   %eax,%eax
80103916:	74 0f                	je     80103927 <fork+0x87>
80103918:	89 04 24             	mov    %eax,(%esp)
8010391b:	e8 c0 d4 ff ff       	call   80100de0 <filedup>
80103920:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103923:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
80103927:	83 c6 01             	add    $0x1,%esi
8010392a:	83 fe 10             	cmp    $0x10,%esi
8010392d:	75 e1                	jne    80103910 <fork+0x70>
8010392f:	8b 43 68             	mov    0x68(%ebx),%eax
80103932:	83 c3 6c             	add    $0x6c,%ebx
80103935:	89 04 24             	mov    %eax,(%esp)
80103938:	e8 43 dd ff ff       	call   80101680 <idup>
8010393d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103940:	89 47 68             	mov    %eax,0x68(%edi)
80103943:	8d 47 6c             	lea    0x6c(%edi),%eax
80103946:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010394a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80103951:	00 
80103952:	89 04 24             	mov    %eax,(%esp)
80103955:	e8 16 0e 00 00       	call   80104770 <safestrcpy>
8010395a:	8b 5f 10             	mov    0x10(%edi),%ebx
8010395d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103964:	e8 67 0b 00 00       	call   801044d0 <acquire>
80103969:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
80103970:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103977:	e8 c4 0b 00 00       	call   80104540 <release>
8010397c:	89 d8                	mov    %ebx,%eax
8010397e:	83 c4 1c             	add    $0x1c,%esp
80103981:	5b                   	pop    %ebx
80103982:	5e                   	pop    %esi
80103983:	5f                   	pop    %edi
80103984:	5d                   	pop    %ebp
80103985:	c3                   	ret    
80103986:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010398b:	eb f1                	jmp    8010397e <fork+0xde>
8010398d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103990:	8b 47 08             	mov    0x8(%edi),%eax
80103993:	89 04 24             	mov    %eax,(%esp)
80103996:	e8 55 e9 ff ff       	call   801022f0 <kfree>
8010399b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801039a0:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
801039a7:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
801039ae:	eb ce                	jmp    8010397e <fork+0xde>

801039b0 <scheduler>:
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	57                   	push   %edi
801039b4:	56                   	push   %esi
801039b5:	53                   	push   %ebx
801039b6:	83 ec 1c             	sub    $0x1c,%esp
801039b9:	e8 92 fc ff ff       	call   80103650 <mycpu>
801039be:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801039c5:	00 00 00 
801039c8:	89 c3                	mov    %eax,%ebx
801039ca:	8d 40 04             	lea    0x4(%eax),%eax
801039cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801039d0:	fb                   	sti    
801039d1:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801039d8:	bf 54 2d 11 80       	mov    $0x80112d54,%edi
801039dd:	e8 ee 0a 00 00       	call   801044d0 <acquire>
801039e2:	eb 16                	jmp    801039fa <scheduler+0x4a>
801039e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039e8:	81 c7 8c 00 00 00    	add    $0x8c,%edi
801039ee:	81 ff 54 50 11 80    	cmp    $0x80115054,%edi
801039f4:	0f 83 d4 00 00 00    	jae    80103ace <scheduler+0x11e>
801039fa:	83 7f 0c 03          	cmpl   $0x3,0xc(%edi)
801039fe:	75 e8                	jne    801039e8 <scheduler+0x38>
80103a00:	8d b7 8c 00 00 00    	lea    0x8c(%edi),%esi
80103a06:	81 fe 54 50 11 80    	cmp    $0x80115054,%esi
80103a0c:	72 10                	jb     80103a1e <scheduler+0x6e>
80103a0e:	eb 37                	jmp    80103a47 <scheduler+0x97>
80103a10:	81 c6 8c 00 00 00    	add    $0x8c,%esi
80103a16:	81 fe 54 50 11 80    	cmp    $0x80115054,%esi
80103a1c:	73 23                	jae    80103a41 <scheduler+0x91>
80103a1e:	83 7e 0c 03          	cmpl   $0x3,0xc(%esi)
80103a22:	75 ec                	jne    80103a10 <scheduler+0x60>
80103a24:	8b 86 80 00 00 00    	mov    0x80(%esi),%eax
80103a2a:	39 87 80 00 00 00    	cmp    %eax,0x80(%edi)
80103a30:	0f 4f fe             	cmovg  %esi,%edi
80103a33:	81 c6 8c 00 00 00    	add    $0x8c,%esi
80103a39:	81 fe 54 50 11 80    	cmp    $0x80115054,%esi
80103a3f:	72 dd                	jb     80103a1e <scheduler+0x6e>
80103a41:	8d b7 8c 00 00 00    	lea    0x8c(%edi),%esi
80103a47:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
80103a4d:	89 3c 24             	mov    %edi,(%esp)
80103a50:	e8 3b 2f 00 00       	call   80106990 <switchuvm>
80103a55:	8b 47 1c             	mov    0x1c(%edi),%eax
80103a58:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
80103a5f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103a63:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103a66:	89 04 24             	mov    %eax,(%esp)
80103a69:	e8 5d 0d 00 00       	call   801047cb <swtch>
80103a6e:	e8 fd 2e 00 00       	call   80106970 <switchkvm>
80103a73:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103a78:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103a7f:	00 00 00 
80103a82:	eb 10                	jmp    80103a94 <scheduler+0xe4>
80103a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103a88:	05 8c 00 00 00       	add    $0x8c,%eax
80103a8d:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80103a92:	74 2c                	je     80103ac0 <scheduler+0x110>
80103a94:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80103a98:	75 ee                	jne    80103a88 <scheduler+0xd8>
80103a9a:	39 f8                	cmp    %edi,%eax
80103a9c:	8b 88 80 00 00 00    	mov    0x80(%eax),%ecx
80103aa2:	74 3c                	je     80103ae0 <scheduler+0x130>
80103aa4:	85 c9                	test   %ecx,%ecx
80103aa6:	7e e0                	jle    80103a88 <scheduler+0xd8>
80103aa8:	83 e9 01             	sub    $0x1,%ecx
80103aab:	05 8c 00 00 00       	add    $0x8c,%eax
80103ab0:	89 48 f4             	mov    %ecx,-0xc(%eax)
80103ab3:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80103ab8:	75 da                	jne    80103a94 <scheduler+0xe4>
80103aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103ac0:	89 f7                	mov    %esi,%edi
80103ac2:	81 ff 54 50 11 80    	cmp    $0x80115054,%edi
80103ac8:	0f 82 2c ff ff ff    	jb     801039fa <scheduler+0x4a>
80103ace:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ad5:	e8 66 0a 00 00       	call   80104540 <release>
80103ada:	e9 f1 fe ff ff       	jmp    801039d0 <scheduler+0x20>
80103adf:	90                   	nop
80103ae0:	83 f9 1e             	cmp    $0x1e,%ecx
80103ae3:	7f a3                	jg     80103a88 <scheduler+0xd8>
80103ae5:	83 c1 01             	add    $0x1,%ecx
80103ae8:	89 88 80 00 00 00    	mov    %ecx,0x80(%eax)
80103aee:	eb 98                	jmp    80103a88 <scheduler+0xd8>

80103af0 <set_prior>:
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	56                   	push   %esi
80103af4:	53                   	push   %ebx
80103af5:	83 ec 10             	sub    $0x10,%esp
80103af8:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103afb:	e8 f0 fb ff ff       	call   801036f0 <myproc>
80103b00:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b07:	89 c6                	mov    %eax,%esi
80103b09:	e8 c2 09 00 00       	call   801044d0 <acquire>
80103b0e:	85 db                	test   %ebx,%ebx
80103b10:	78 26                	js     80103b38 <set_prior+0x48>
80103b12:	ba 1f 00 00 00       	mov    $0x1f,%edx
80103b17:	83 fb 20             	cmp    $0x20,%ebx
80103b1a:	0f 4c d3             	cmovl  %ebx,%edx
80103b1d:	89 96 80 00 00 00    	mov    %edx,0x80(%esi)
80103b23:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b2a:	e8 11 0a 00 00       	call   80104540 <release>
80103b2f:	83 c4 10             	add    $0x10,%esp
80103b32:	89 d8                	mov    %ebx,%eax
80103b34:	5b                   	pop    %ebx
80103b35:	5e                   	pop    %esi
80103b36:	5d                   	pop    %ebp
80103b37:	c3                   	ret    
80103b38:	c7 86 80 00 00 00 00 	movl   $0x0,0x80(%esi)
80103b3f:	00 00 00 
80103b42:	eb df                	jmp    80103b23 <set_prior+0x33>
80103b44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103b4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103b50 <sched>:
80103b50:	55                   	push   %ebp
80103b51:	89 e5                	mov    %esp,%ebp
80103b53:	56                   	push   %esi
80103b54:	53                   	push   %ebx
80103b55:	83 ec 10             	sub    $0x10,%esp
80103b58:	e8 93 fb ff ff       	call   801036f0 <myproc>
80103b5d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b64:	89 c3                	mov    %eax,%ebx
80103b66:	e8 25 09 00 00       	call   80104490 <holding>
80103b6b:	85 c0                	test   %eax,%eax
80103b6d:	74 4f                	je     80103bbe <sched+0x6e>
80103b6f:	e8 dc fa ff ff       	call   80103650 <mycpu>
80103b74:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103b7b:	75 65                	jne    80103be2 <sched+0x92>
80103b7d:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103b81:	74 53                	je     80103bd6 <sched+0x86>
80103b83:	9c                   	pushf  
80103b84:	58                   	pop    %eax
80103b85:	f6 c4 02             	test   $0x2,%ah
80103b88:	75 40                	jne    80103bca <sched+0x7a>
80103b8a:	e8 c1 fa ff ff       	call   80103650 <mycpu>
80103b8f:	83 c3 1c             	add    $0x1c,%ebx
80103b92:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
80103b98:	e8 b3 fa ff ff       	call   80103650 <mycpu>
80103b9d:	8b 40 04             	mov    0x4(%eax),%eax
80103ba0:	89 1c 24             	mov    %ebx,(%esp)
80103ba3:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ba7:	e8 1f 0c 00 00       	call   801047cb <swtch>
80103bac:	e8 9f fa ff ff       	call   80103650 <mycpu>
80103bb1:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
80103bb7:	83 c4 10             	add    $0x10,%esp
80103bba:	5b                   	pop    %ebx
80103bbb:	5e                   	pop    %esi
80103bbc:	5d                   	pop    %ebp
80103bbd:	c3                   	ret    
80103bbe:	c7 04 24 c0 75 10 80 	movl   $0x801075c0,(%esp)
80103bc5:	e8 96 c7 ff ff       	call   80100360 <panic>
80103bca:	c7 04 24 ec 75 10 80 	movl   $0x801075ec,(%esp)
80103bd1:	e8 8a c7 ff ff       	call   80100360 <panic>
80103bd6:	c7 04 24 de 75 10 80 	movl   $0x801075de,(%esp)
80103bdd:	e8 7e c7 ff ff       	call   80100360 <panic>
80103be2:	c7 04 24 d2 75 10 80 	movl   $0x801075d2,(%esp)
80103be9:	e8 72 c7 ff ff       	call   80100360 <panic>
80103bee:	66 90                	xchg   %ax,%ax

80103bf0 <exit>:
80103bf0:	55                   	push   %ebp
80103bf1:	89 e5                	mov    %esp,%ebp
80103bf3:	56                   	push   %esi
80103bf4:	53                   	push   %ebx
80103bf5:	83 ec 10             	sub    $0x10,%esp
80103bf8:	e8 f3 fa ff ff       	call   801036f0 <myproc>
80103bfd:	3b 05 b8 a5 10 80    	cmp    0x8010a5b8,%eax
80103c03:	89 c3                	mov    %eax,%ebx
80103c05:	0f 84 3e 01 00 00    	je     80103d49 <exit+0x159>
80103c0b:	8b 45 08             	mov    0x8(%ebp),%eax
80103c0e:	31 f6                	xor    %esi,%esi
80103c10:	89 43 7c             	mov    %eax,0x7c(%ebx)
80103c13:	90                   	nop
80103c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c18:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103c1c:	85 c0                	test   %eax,%eax
80103c1e:	74 10                	je     80103c30 <exit+0x40>
80103c20:	89 04 24             	mov    %eax,(%esp)
80103c23:	e8 08 d2 ff ff       	call   80100e30 <fileclose>
80103c28:	c7 44 b3 28 00 00 00 	movl   $0x0,0x28(%ebx,%esi,4)
80103c2f:	00 
80103c30:	83 c6 01             	add    $0x1,%esi
80103c33:	83 fe 10             	cmp    $0x10,%esi
80103c36:	75 e0                	jne    80103c18 <exit+0x28>
80103c38:	e8 d3 ee ff ff       	call   80102b10 <begin_op>
80103c3d:	8b 43 68             	mov    0x68(%ebx),%eax
80103c40:	89 04 24             	mov    %eax,(%esp)
80103c43:	e8 88 db ff ff       	call   801017d0 <iput>
80103c48:	e8 33 ef ff ff       	call   80102b80 <end_op>
80103c4d:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
80103c54:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c5b:	e8 70 08 00 00       	call   801044d0 <acquire>
80103c60:	8b 43 14             	mov    0x14(%ebx),%eax
80103c63:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103c68:	eb 14                	jmp    80103c7e <exit+0x8e>
80103c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c70:	81 c2 8c 00 00 00    	add    $0x8c,%edx
80103c76:	81 fa 54 50 11 80    	cmp    $0x80115054,%edx
80103c7c:	74 20                	je     80103c9e <exit+0xae>
80103c7e:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103c82:	75 ec                	jne    80103c70 <exit+0x80>
80103c84:	3b 42 20             	cmp    0x20(%edx),%eax
80103c87:	75 e7                	jne    80103c70 <exit+0x80>
80103c89:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
80103c90:	81 c2 8c 00 00 00    	add    $0x8c,%edx
80103c96:	81 fa 54 50 11 80    	cmp    $0x80115054,%edx
80103c9c:	75 e0                	jne    80103c7e <exit+0x8e>
80103c9e:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
80103ca3:	b9 54 2d 11 80       	mov    $0x80112d54,%ecx
80103ca8:	eb 14                	jmp    80103cbe <exit+0xce>
80103caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103cb0:	81 c1 8c 00 00 00    	add    $0x8c,%ecx
80103cb6:	81 f9 54 50 11 80    	cmp    $0x80115054,%ecx
80103cbc:	74 3c                	je     80103cfa <exit+0x10a>
80103cbe:	39 59 14             	cmp    %ebx,0x14(%ecx)
80103cc1:	75 ed                	jne    80103cb0 <exit+0xc0>
80103cc3:	83 79 0c 05          	cmpl   $0x5,0xc(%ecx)
80103cc7:	89 41 14             	mov    %eax,0x14(%ecx)
80103cca:	75 e4                	jne    80103cb0 <exit+0xc0>
80103ccc:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103cd1:	eb 13                	jmp    80103ce6 <exit+0xf6>
80103cd3:	90                   	nop
80103cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103cd8:	81 c2 8c 00 00 00    	add    $0x8c,%edx
80103cde:	81 fa 54 50 11 80    	cmp    $0x80115054,%edx
80103ce4:	74 ca                	je     80103cb0 <exit+0xc0>
80103ce6:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103cea:	75 ec                	jne    80103cd8 <exit+0xe8>
80103cec:	3b 42 20             	cmp    0x20(%edx),%eax
80103cef:	75 e7                	jne    80103cd8 <exit+0xe8>
80103cf1:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
80103cf8:	eb de                	jmp    80103cd8 <exit+0xe8>
80103cfa:	a1 a0 58 11 80       	mov    0x801158a0,%eax
80103cff:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
80103d06:	89 83 88 00 00 00    	mov    %eax,0x88(%ebx)
80103d0c:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d10:	c7 04 24 0d 76 10 80 	movl   $0x8010760d,(%esp)
80103d17:	e8 34 c9 ff ff       	call   80100650 <cprintf>
80103d1c:	8b 83 88 00 00 00    	mov    0x88(%ebx),%eax
80103d22:	2b 83 84 00 00 00    	sub    0x84(%ebx),%eax
80103d28:	c7 04 24 1c 76 10 80 	movl   $0x8010761c,(%esp)
80103d2f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d33:	e8 18 c9 ff ff       	call   80100650 <cprintf>
80103d38:	e8 13 fe ff ff       	call   80103b50 <sched>
80103d3d:	c7 04 24 32 76 10 80 	movl   $0x80107632,(%esp)
80103d44:	e8 17 c6 ff ff       	call   80100360 <panic>
80103d49:	c7 04 24 00 76 10 80 	movl   $0x80107600,(%esp)
80103d50:	e8 0b c6 ff ff       	call   80100360 <panic>
80103d55:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d60 <yield>:
80103d60:	55                   	push   %ebp
80103d61:	89 e5                	mov    %esp,%ebp
80103d63:	83 ec 18             	sub    $0x18,%esp
80103d66:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d6d:	e8 5e 07 00 00       	call   801044d0 <acquire>
80103d72:	e8 79 f9 ff ff       	call   801036f0 <myproc>
80103d77:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103d7e:	e8 cd fd ff ff       	call   80103b50 <sched>
80103d83:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d8a:	e8 b1 07 00 00       	call   80104540 <release>
80103d8f:	c9                   	leave  
80103d90:	c3                   	ret    
80103d91:	eb 0d                	jmp    80103da0 <sleep>
80103d93:	90                   	nop
80103d94:	90                   	nop
80103d95:	90                   	nop
80103d96:	90                   	nop
80103d97:	90                   	nop
80103d98:	90                   	nop
80103d99:	90                   	nop
80103d9a:	90                   	nop
80103d9b:	90                   	nop
80103d9c:	90                   	nop
80103d9d:	90                   	nop
80103d9e:	90                   	nop
80103d9f:	90                   	nop

80103da0 <sleep>:
80103da0:	55                   	push   %ebp
80103da1:	89 e5                	mov    %esp,%ebp
80103da3:	57                   	push   %edi
80103da4:	56                   	push   %esi
80103da5:	53                   	push   %ebx
80103da6:	83 ec 1c             	sub    $0x1c,%esp
80103da9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103dac:	8b 75 0c             	mov    0xc(%ebp),%esi
80103daf:	e8 3c f9 ff ff       	call   801036f0 <myproc>
80103db4:	85 c0                	test   %eax,%eax
80103db6:	89 c3                	mov    %eax,%ebx
80103db8:	0f 84 7c 00 00 00    	je     80103e3a <sleep+0x9a>
80103dbe:	85 f6                	test   %esi,%esi
80103dc0:	74 6c                	je     80103e2e <sleep+0x8e>
80103dc2:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103dc8:	74 46                	je     80103e10 <sleep+0x70>
80103dca:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103dd1:	e8 fa 06 00 00       	call   801044d0 <acquire>
80103dd6:	89 34 24             	mov    %esi,(%esp)
80103dd9:	e8 62 07 00 00       	call   80104540 <release>
80103dde:	89 7b 20             	mov    %edi,0x20(%ebx)
80103de1:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
80103de8:	e8 63 fd ff ff       	call   80103b50 <sched>
80103ded:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
80103df4:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103dfb:	e8 40 07 00 00       	call   80104540 <release>
80103e00:	89 75 08             	mov    %esi,0x8(%ebp)
80103e03:	83 c4 1c             	add    $0x1c,%esp
80103e06:	5b                   	pop    %ebx
80103e07:	5e                   	pop    %esi
80103e08:	5f                   	pop    %edi
80103e09:	5d                   	pop    %ebp
80103e0a:	e9 c1 06 00 00       	jmp    801044d0 <acquire>
80103e0f:	90                   	nop
80103e10:	89 78 20             	mov    %edi,0x20(%eax)
80103e13:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
80103e1a:	e8 31 fd ff ff       	call   80103b50 <sched>
80103e1f:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
80103e26:	83 c4 1c             	add    $0x1c,%esp
80103e29:	5b                   	pop    %ebx
80103e2a:	5e                   	pop    %esi
80103e2b:	5f                   	pop    %edi
80103e2c:	5d                   	pop    %ebp
80103e2d:	c3                   	ret    
80103e2e:	c7 04 24 44 76 10 80 	movl   $0x80107644,(%esp)
80103e35:	e8 26 c5 ff ff       	call   80100360 <panic>
80103e3a:	c7 04 24 3e 76 10 80 	movl   $0x8010763e,(%esp)
80103e41:	e8 1a c5 ff ff       	call   80100360 <panic>
80103e46:	8d 76 00             	lea    0x0(%esi),%esi
80103e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e50 <wait>:
80103e50:	55                   	push   %ebp
80103e51:	89 e5                	mov    %esp,%ebp
80103e53:	57                   	push   %edi
80103e54:	56                   	push   %esi
80103e55:	53                   	push   %ebx
80103e56:	83 ec 1c             	sub    $0x1c,%esp
80103e59:	8b 7d 08             	mov    0x8(%ebp),%edi
80103e5c:	e8 8f f8 ff ff       	call   801036f0 <myproc>
80103e61:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103e68:	89 c6                	mov    %eax,%esi
80103e6a:	e8 61 06 00 00       	call   801044d0 <acquire>
80103e6f:	31 c0                	xor    %eax,%eax
80103e71:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103e76:	eb 0e                	jmp    80103e86 <wait+0x36>
80103e78:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103e7e:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
80103e84:	74 22                	je     80103ea8 <wait+0x58>
80103e86:	39 73 14             	cmp    %esi,0x14(%ebx)
80103e89:	75 ed                	jne    80103e78 <wait+0x28>
80103e8b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103e8f:	74 34                	je     80103ec5 <wait+0x75>
80103e91:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103e97:	b8 01 00 00 00       	mov    $0x1,%eax
80103e9c:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
80103ea2:	75 e2                	jne    80103e86 <wait+0x36>
80103ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ea8:	85 c0                	test   %eax,%eax
80103eaa:	74 78                	je     80103f24 <wait+0xd4>
80103eac:	8b 46 24             	mov    0x24(%esi),%eax
80103eaf:	85 c0                	test   %eax,%eax
80103eb1:	75 71                	jne    80103f24 <wait+0xd4>
80103eb3:	c7 44 24 04 20 2d 11 	movl   $0x80112d20,0x4(%esp)
80103eba:	80 
80103ebb:	89 34 24             	mov    %esi,(%esp)
80103ebe:	e8 dd fe ff ff       	call   80103da0 <sleep>
80103ec3:	eb aa                	jmp    80103e6f <wait+0x1f>
80103ec5:	8b 43 08             	mov    0x8(%ebx),%eax
80103ec8:	8b 73 10             	mov    0x10(%ebx),%esi
80103ecb:	89 04 24             	mov    %eax,(%esp)
80103ece:	e8 1d e4 ff ff       	call   801022f0 <kfree>
80103ed3:	8b 43 04             	mov    0x4(%ebx),%eax
80103ed6:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80103edd:	89 04 24             	mov    %eax,(%esp)
80103ee0:	e8 0b 2e 00 00       	call   80106cf0 <freevm>
80103ee5:	85 ff                	test   %edi,%edi
80103ee7:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
80103eee:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
80103ef5:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
80103ef9:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
80103f00:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80103f07:	74 05                	je     80103f0e <wait+0xbe>
80103f09:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103f0c:	89 07                	mov    %eax,(%edi)
80103f0e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f15:	e8 26 06 00 00       	call   80104540 <release>
80103f1a:	83 c4 1c             	add    $0x1c,%esp
80103f1d:	89 f0                	mov    %esi,%eax
80103f1f:	5b                   	pop    %ebx
80103f20:	5e                   	pop    %esi
80103f21:	5f                   	pop    %edi
80103f22:	5d                   	pop    %ebp
80103f23:	c3                   	ret    
80103f24:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f2b:	e8 10 06 00 00       	call   80104540 <release>
80103f30:	83 c4 1c             	add    $0x1c,%esp
80103f33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103f38:	5b                   	pop    %ebx
80103f39:	5e                   	pop    %esi
80103f3a:	5f                   	pop    %edi
80103f3b:	5d                   	pop    %ebp
80103f3c:	c3                   	ret    
80103f3d:	8d 76 00             	lea    0x0(%esi),%esi

80103f40 <waitpid>:
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	57                   	push   %edi
80103f44:	56                   	push   %esi
80103f45:	53                   	push   %ebx
80103f46:	83 ec 1c             	sub    $0x1c,%esp
80103f49:	8b 55 08             	mov    0x8(%ebp),%edx
80103f4c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103f4f:	e8 9c f7 ff ff       	call   801036f0 <myproc>
80103f54:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f5b:	89 c6                	mov    %eax,%esi
80103f5d:	e8 6e 05 00 00       	call   801044d0 <acquire>
80103f62:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103f65:	8d 76 00             	lea    0x0(%esi),%esi
80103f68:	31 c0                	xor    %eax,%eax
80103f6a:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103f6f:	eb 15                	jmp    80103f86 <waitpid+0x46>
80103f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f78:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103f7e:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
80103f84:	74 7a                	je     80104000 <waitpid+0xc0>
80103f86:	39 73 14             	cmp    %esi,0x14(%ebx)
80103f89:	75 ed                	jne    80103f78 <waitpid+0x38>
80103f8b:	8b 7b 10             	mov    0x10(%ebx),%edi
80103f8e:	b8 01 00 00 00       	mov    $0x1,%eax
80103f93:	39 d7                	cmp    %edx,%edi
80103f95:	75 e1                	jne    80103f78 <waitpid+0x38>
80103f97:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f9b:	75 db                	jne    80103f78 <waitpid+0x38>
80103f9d:	8b 43 08             	mov    0x8(%ebx),%eax
80103fa0:	89 04 24             	mov    %eax,(%esp)
80103fa3:	e8 48 e3 ff ff       	call   801022f0 <kfree>
80103fa8:	8b 43 04             	mov    0x4(%ebx),%eax
80103fab:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80103fb2:	89 04 24             	mov    %eax,(%esp)
80103fb5:	e8 36 2d 00 00       	call   80106cf0 <freevm>
80103fba:	8b 55 0c             	mov    0xc(%ebp),%edx
80103fbd:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
80103fc4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
80103fcb:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
80103fcf:	85 d2                	test   %edx,%edx
80103fd1:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
80103fd8:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80103fdf:	74 08                	je     80103fe9 <waitpid+0xa9>
80103fe1:	8b 43 7c             	mov    0x7c(%ebx),%eax
80103fe4:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103fe7:	89 01                	mov    %eax,(%ecx)
80103fe9:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ff0:	e8 4b 05 00 00       	call   80104540 <release>
80103ff5:	83 c4 1c             	add    $0x1c,%esp
80103ff8:	89 f8                	mov    %edi,%eax
80103ffa:	5b                   	pop    %ebx
80103ffb:	5e                   	pop    %esi
80103ffc:	5f                   	pop    %edi
80103ffd:	5d                   	pop    %ebp
80103ffe:	c3                   	ret    
80103fff:	90                   	nop
80104000:	85 c0                	test   %eax,%eax
80104002:	74 22                	je     80104026 <waitpid+0xe6>
80104004:	8b 46 24             	mov    0x24(%esi),%eax
80104007:	85 c0                	test   %eax,%eax
80104009:	75 1b                	jne    80104026 <waitpid+0xe6>
8010400b:	c7 44 24 04 20 2d 11 	movl   $0x80112d20,0x4(%esp)
80104012:	80 
80104013:	89 34 24             	mov    %esi,(%esp)
80104016:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80104019:	e8 82 fd ff ff       	call   80103da0 <sleep>
8010401e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104021:	e9 42 ff ff ff       	jmp    80103f68 <waitpid+0x28>
80104026:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010402d:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80104032:	e8 09 05 00 00       	call   80104540 <release>
80104037:	83 c4 1c             	add    $0x1c,%esp
8010403a:	89 f8                	mov    %edi,%eax
8010403c:	5b                   	pop    %ebx
8010403d:	5e                   	pop    %esi
8010403e:	5f                   	pop    %edi
8010403f:	5d                   	pop    %ebp
80104040:	c3                   	ret    
80104041:	eb 0d                	jmp    80104050 <wakeup>
80104043:	90                   	nop
80104044:	90                   	nop
80104045:	90                   	nop
80104046:	90                   	nop
80104047:	90                   	nop
80104048:	90                   	nop
80104049:	90                   	nop
8010404a:	90                   	nop
8010404b:	90                   	nop
8010404c:	90                   	nop
8010404d:	90                   	nop
8010404e:	90                   	nop
8010404f:	90                   	nop

80104050 <wakeup>:
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	53                   	push   %ebx
80104054:	83 ec 14             	sub    $0x14,%esp
80104057:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010405a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104061:	e8 6a 04 00 00       	call   801044d0 <acquire>
80104066:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010406b:	eb 0f                	jmp    8010407c <wakeup+0x2c>
8010406d:	8d 76 00             	lea    0x0(%esi),%esi
80104070:	05 8c 00 00 00       	add    $0x8c,%eax
80104075:	3d 54 50 11 80       	cmp    $0x80115054,%eax
8010407a:	74 24                	je     801040a0 <wakeup+0x50>
8010407c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104080:	75 ee                	jne    80104070 <wakeup+0x20>
80104082:	3b 58 20             	cmp    0x20(%eax),%ebx
80104085:	75 e9                	jne    80104070 <wakeup+0x20>
80104087:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010408e:	05 8c 00 00 00       	add    $0x8c,%eax
80104093:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80104098:	75 e2                	jne    8010407c <wakeup+0x2c>
8010409a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801040a0:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
801040a7:	83 c4 14             	add    $0x14,%esp
801040aa:	5b                   	pop    %ebx
801040ab:	5d                   	pop    %ebp
801040ac:	e9 8f 04 00 00       	jmp    80104540 <release>
801040b1:	eb 0d                	jmp    801040c0 <kill>
801040b3:	90                   	nop
801040b4:	90                   	nop
801040b5:	90                   	nop
801040b6:	90                   	nop
801040b7:	90                   	nop
801040b8:	90                   	nop
801040b9:	90                   	nop
801040ba:	90                   	nop
801040bb:	90                   	nop
801040bc:	90                   	nop
801040bd:	90                   	nop
801040be:	90                   	nop
801040bf:	90                   	nop

801040c0 <kill>:
801040c0:	55                   	push   %ebp
801040c1:	89 e5                	mov    %esp,%ebp
801040c3:	53                   	push   %ebx
801040c4:	83 ec 14             	sub    $0x14,%esp
801040c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801040ca:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801040d1:	e8 fa 03 00 00       	call   801044d0 <acquire>
801040d6:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801040db:	eb 0f                	jmp    801040ec <kill+0x2c>
801040dd:	8d 76 00             	lea    0x0(%esi),%esi
801040e0:	05 8c 00 00 00       	add    $0x8c,%eax
801040e5:	3d 54 50 11 80       	cmp    $0x80115054,%eax
801040ea:	74 3c                	je     80104128 <kill+0x68>
801040ec:	39 58 10             	cmp    %ebx,0x10(%eax)
801040ef:	75 ef                	jne    801040e0 <kill+0x20>
801040f1:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801040f5:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
801040fc:	74 1a                	je     80104118 <kill+0x58>
801040fe:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104105:	e8 36 04 00 00       	call   80104540 <release>
8010410a:	83 c4 14             	add    $0x14,%esp
8010410d:	31 c0                	xor    %eax,%eax
8010410f:	5b                   	pop    %ebx
80104110:	5d                   	pop    %ebp
80104111:	c3                   	ret    
80104112:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104118:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010411f:	eb dd                	jmp    801040fe <kill+0x3e>
80104121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104128:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010412f:	e8 0c 04 00 00       	call   80104540 <release>
80104134:	83 c4 14             	add    $0x14,%esp
80104137:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010413c:	5b                   	pop    %ebx
8010413d:	5d                   	pop    %ebp
8010413e:	c3                   	ret    
8010413f:	90                   	nop

80104140 <procdump>:
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	57                   	push   %edi
80104144:	56                   	push   %esi
80104145:	53                   	push   %ebx
80104146:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
8010414b:	83 ec 4c             	sub    $0x4c,%esp
8010414e:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104151:	eb 23                	jmp    80104176 <procdump+0x36>
80104153:	90                   	nop
80104154:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104158:	c7 04 24 1a 76 10 80 	movl   $0x8010761a,(%esp)
8010415f:	e8 ec c4 ff ff       	call   80100650 <cprintf>
80104164:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
8010416a:	81 fb c0 50 11 80    	cmp    $0x801150c0,%ebx
80104170:	0f 84 8a 00 00 00    	je     80104200 <procdump+0xc0>
80104176:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104179:	85 c0                	test   %eax,%eax
8010417b:	74 e7                	je     80104164 <procdump+0x24>
8010417d:	83 f8 05             	cmp    $0x5,%eax
80104180:	ba 55 76 10 80       	mov    $0x80107655,%edx
80104185:	77 11                	ja     80104198 <procdump+0x58>
80104187:	8b 14 85 dc 76 10 80 	mov    -0x7fef8924(,%eax,4),%edx
8010418e:	b8 55 76 10 80       	mov    $0x80107655,%eax
80104193:	85 d2                	test   %edx,%edx
80104195:	0f 44 d0             	cmove  %eax,%edx
80104198:	8b 43 a4             	mov    -0x5c(%ebx),%eax
8010419b:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
8010419f:	89 54 24 08          	mov    %edx,0x8(%esp)
801041a3:	c7 04 24 59 76 10 80 	movl   $0x80107659,(%esp)
801041aa:	89 44 24 04          	mov    %eax,0x4(%esp)
801041ae:	e8 9d c4 ff ff       	call   80100650 <cprintf>
801041b3:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801041b7:	75 9f                	jne    80104158 <procdump+0x18>
801041b9:	8d 45 c0             	lea    -0x40(%ebp),%eax
801041bc:	89 44 24 04          	mov    %eax,0x4(%esp)
801041c0:	8b 43 b0             	mov    -0x50(%ebx),%eax
801041c3:	8d 7d c0             	lea    -0x40(%ebp),%edi
801041c6:	8b 40 0c             	mov    0xc(%eax),%eax
801041c9:	83 c0 08             	add    $0x8,%eax
801041cc:	89 04 24             	mov    %eax,(%esp)
801041cf:	e8 ac 01 00 00       	call   80104380 <getcallerpcs>
801041d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801041d8:	8b 17                	mov    (%edi),%edx
801041da:	85 d2                	test   %edx,%edx
801041dc:	0f 84 76 ff ff ff    	je     80104158 <procdump+0x18>
801041e2:	89 54 24 04          	mov    %edx,0x4(%esp)
801041e6:	83 c7 04             	add    $0x4,%edi
801041e9:	c7 04 24 61 70 10 80 	movl   $0x80107061,(%esp)
801041f0:	e8 5b c4 ff ff       	call   80100650 <cprintf>
801041f5:	39 f7                	cmp    %esi,%edi
801041f7:	75 df                	jne    801041d8 <procdump+0x98>
801041f9:	e9 5a ff ff ff       	jmp    80104158 <procdump+0x18>
801041fe:	66 90                	xchg   %ax,%ax
80104200:	83 c4 4c             	add    $0x4c,%esp
80104203:	5b                   	pop    %ebx
80104204:	5e                   	pop    %esi
80104205:	5f                   	pop    %edi
80104206:	5d                   	pop    %ebp
80104207:	c3                   	ret    
80104208:	90                   	nop
80104209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104210 <hello>:
80104210:	55                   	push   %ebp
80104211:	89 e5                	mov    %esp,%ebp
80104213:	83 ec 18             	sub    $0x18,%esp
80104216:	c7 04 24 b4 76 10 80 	movl   $0x801076b4,(%esp)
8010421d:	e8 2e c4 ff ff       	call   80100650 <cprintf>
80104222:	c9                   	leave  
80104223:	c3                   	ret    
80104224:	66 90                	xchg   %ax,%ax
80104226:	66 90                	xchg   %ax,%ax
80104228:	66 90                	xchg   %ax,%ax
8010422a:	66 90                	xchg   %ax,%ax
8010422c:	66 90                	xchg   %ax,%ax
8010422e:	66 90                	xchg   %ax,%ax

80104230 <initsleeplock>:
80104230:	55                   	push   %ebp
80104231:	89 e5                	mov    %esp,%ebp
80104233:	53                   	push   %ebx
80104234:	83 ec 14             	sub    $0x14,%esp
80104237:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010423a:	c7 44 24 04 f4 76 10 	movl   $0x801076f4,0x4(%esp)
80104241:	80 
80104242:	8d 43 04             	lea    0x4(%ebx),%eax
80104245:	89 04 24             	mov    %eax,(%esp)
80104248:	e8 13 01 00 00       	call   80104360 <initlock>
8010424d:	8b 45 0c             	mov    0xc(%ebp),%eax
80104250:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104256:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
8010425d:	89 43 38             	mov    %eax,0x38(%ebx)
80104260:	83 c4 14             	add    $0x14,%esp
80104263:	5b                   	pop    %ebx
80104264:	5d                   	pop    %ebp
80104265:	c3                   	ret    
80104266:	8d 76 00             	lea    0x0(%esi),%esi
80104269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104270 <acquiresleep>:
80104270:	55                   	push   %ebp
80104271:	89 e5                	mov    %esp,%ebp
80104273:	56                   	push   %esi
80104274:	53                   	push   %ebx
80104275:	83 ec 10             	sub    $0x10,%esp
80104278:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010427b:	8d 73 04             	lea    0x4(%ebx),%esi
8010427e:	89 34 24             	mov    %esi,(%esp)
80104281:	e8 4a 02 00 00       	call   801044d0 <acquire>
80104286:	8b 13                	mov    (%ebx),%edx
80104288:	85 d2                	test   %edx,%edx
8010428a:	74 16                	je     801042a2 <acquiresleep+0x32>
8010428c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104290:	89 74 24 04          	mov    %esi,0x4(%esp)
80104294:	89 1c 24             	mov    %ebx,(%esp)
80104297:	e8 04 fb ff ff       	call   80103da0 <sleep>
8010429c:	8b 03                	mov    (%ebx),%eax
8010429e:	85 c0                	test   %eax,%eax
801042a0:	75 ee                	jne    80104290 <acquiresleep+0x20>
801042a2:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
801042a8:	e8 43 f4 ff ff       	call   801036f0 <myproc>
801042ad:	8b 40 10             	mov    0x10(%eax),%eax
801042b0:	89 43 3c             	mov    %eax,0x3c(%ebx)
801042b3:	89 75 08             	mov    %esi,0x8(%ebp)
801042b6:	83 c4 10             	add    $0x10,%esp
801042b9:	5b                   	pop    %ebx
801042ba:	5e                   	pop    %esi
801042bb:	5d                   	pop    %ebp
801042bc:	e9 7f 02 00 00       	jmp    80104540 <release>
801042c1:	eb 0d                	jmp    801042d0 <releasesleep>
801042c3:	90                   	nop
801042c4:	90                   	nop
801042c5:	90                   	nop
801042c6:	90                   	nop
801042c7:	90                   	nop
801042c8:	90                   	nop
801042c9:	90                   	nop
801042ca:	90                   	nop
801042cb:	90                   	nop
801042cc:	90                   	nop
801042cd:	90                   	nop
801042ce:	90                   	nop
801042cf:	90                   	nop

801042d0 <releasesleep>:
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	56                   	push   %esi
801042d4:	53                   	push   %ebx
801042d5:	83 ec 10             	sub    $0x10,%esp
801042d8:	8b 5d 08             	mov    0x8(%ebp),%ebx
801042db:	8d 73 04             	lea    0x4(%ebx),%esi
801042de:	89 34 24             	mov    %esi,(%esp)
801042e1:	e8 ea 01 00 00       	call   801044d0 <acquire>
801042e6:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801042ec:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
801042f3:	89 1c 24             	mov    %ebx,(%esp)
801042f6:	e8 55 fd ff ff       	call   80104050 <wakeup>
801042fb:	89 75 08             	mov    %esi,0x8(%ebp)
801042fe:	83 c4 10             	add    $0x10,%esp
80104301:	5b                   	pop    %ebx
80104302:	5e                   	pop    %esi
80104303:	5d                   	pop    %ebp
80104304:	e9 37 02 00 00       	jmp    80104540 <release>
80104309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104310 <holdingsleep>:
80104310:	55                   	push   %ebp
80104311:	89 e5                	mov    %esp,%ebp
80104313:	57                   	push   %edi
80104314:	31 ff                	xor    %edi,%edi
80104316:	56                   	push   %esi
80104317:	53                   	push   %ebx
80104318:	83 ec 1c             	sub    $0x1c,%esp
8010431b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010431e:	8d 73 04             	lea    0x4(%ebx),%esi
80104321:	89 34 24             	mov    %esi,(%esp)
80104324:	e8 a7 01 00 00       	call   801044d0 <acquire>
80104329:	8b 03                	mov    (%ebx),%eax
8010432b:	85 c0                	test   %eax,%eax
8010432d:	74 13                	je     80104342 <holdingsleep+0x32>
8010432f:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104332:	e8 b9 f3 ff ff       	call   801036f0 <myproc>
80104337:	3b 58 10             	cmp    0x10(%eax),%ebx
8010433a:	0f 94 c0             	sete   %al
8010433d:	0f b6 c0             	movzbl %al,%eax
80104340:	89 c7                	mov    %eax,%edi
80104342:	89 34 24             	mov    %esi,(%esp)
80104345:	e8 f6 01 00 00       	call   80104540 <release>
8010434a:	83 c4 1c             	add    $0x1c,%esp
8010434d:	89 f8                	mov    %edi,%eax
8010434f:	5b                   	pop    %ebx
80104350:	5e                   	pop    %esi
80104351:	5f                   	pop    %edi
80104352:	5d                   	pop    %ebp
80104353:	c3                   	ret    
80104354:	66 90                	xchg   %ax,%ax
80104356:	66 90                	xchg   %ax,%ax
80104358:	66 90                	xchg   %ax,%ax
8010435a:	66 90                	xchg   %ax,%ax
8010435c:	66 90                	xchg   %ax,%ax
8010435e:	66 90                	xchg   %ax,%ax

80104360 <initlock>:
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	8b 45 08             	mov    0x8(%ebp),%eax
80104366:	8b 55 0c             	mov    0xc(%ebp),%edx
80104369:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010436f:	89 50 04             	mov    %edx,0x4(%eax)
80104372:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104379:	5d                   	pop    %ebp
8010437a:	c3                   	ret    
8010437b:	90                   	nop
8010437c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104380 <getcallerpcs>:
80104380:	55                   	push   %ebp
80104381:	89 e5                	mov    %esp,%ebp
80104383:	8b 45 08             	mov    0x8(%ebp),%eax
80104386:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104389:	53                   	push   %ebx
8010438a:	8d 50 f8             	lea    -0x8(%eax),%edx
8010438d:	31 c0                	xor    %eax,%eax
8010438f:	90                   	nop
80104390:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104396:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010439c:	77 1a                	ja     801043b8 <getcallerpcs+0x38>
8010439e:	8b 5a 04             	mov    0x4(%edx),%ebx
801043a1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
801043a4:	83 c0 01             	add    $0x1,%eax
801043a7:	8b 12                	mov    (%edx),%edx
801043a9:	83 f8 0a             	cmp    $0xa,%eax
801043ac:	75 e2                	jne    80104390 <getcallerpcs+0x10>
801043ae:	5b                   	pop    %ebx
801043af:	5d                   	pop    %ebp
801043b0:	c3                   	ret    
801043b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043b8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
801043bf:	83 c0 01             	add    $0x1,%eax
801043c2:	83 f8 0a             	cmp    $0xa,%eax
801043c5:	74 e7                	je     801043ae <getcallerpcs+0x2e>
801043c7:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
801043ce:	83 c0 01             	add    $0x1,%eax
801043d1:	83 f8 0a             	cmp    $0xa,%eax
801043d4:	75 e2                	jne    801043b8 <getcallerpcs+0x38>
801043d6:	eb d6                	jmp    801043ae <getcallerpcs+0x2e>
801043d8:	90                   	nop
801043d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043e0 <pushcli>:
801043e0:	55                   	push   %ebp
801043e1:	89 e5                	mov    %esp,%ebp
801043e3:	53                   	push   %ebx
801043e4:	83 ec 04             	sub    $0x4,%esp
801043e7:	9c                   	pushf  
801043e8:	5b                   	pop    %ebx
801043e9:	fa                   	cli    
801043ea:	e8 61 f2 ff ff       	call   80103650 <mycpu>
801043ef:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801043f5:	85 c0                	test   %eax,%eax
801043f7:	75 11                	jne    8010440a <pushcli+0x2a>
801043f9:	e8 52 f2 ff ff       	call   80103650 <mycpu>
801043fe:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104404:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
8010440a:	e8 41 f2 ff ff       	call   80103650 <mycpu>
8010440f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
80104416:	83 c4 04             	add    $0x4,%esp
80104419:	5b                   	pop    %ebx
8010441a:	5d                   	pop    %ebp
8010441b:	c3                   	ret    
8010441c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104420 <popcli>:
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	83 ec 18             	sub    $0x18,%esp
80104426:	9c                   	pushf  
80104427:	58                   	pop    %eax
80104428:	f6 c4 02             	test   $0x2,%ah
8010442b:	75 49                	jne    80104476 <popcli+0x56>
8010442d:	e8 1e f2 ff ff       	call   80103650 <mycpu>
80104432:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104438:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010443b:	85 d2                	test   %edx,%edx
8010443d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104443:	78 25                	js     8010446a <popcli+0x4a>
80104445:	e8 06 f2 ff ff       	call   80103650 <mycpu>
8010444a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104450:	85 d2                	test   %edx,%edx
80104452:	74 04                	je     80104458 <popcli+0x38>
80104454:	c9                   	leave  
80104455:	c3                   	ret    
80104456:	66 90                	xchg   %ax,%ax
80104458:	e8 f3 f1 ff ff       	call   80103650 <mycpu>
8010445d:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104463:	85 c0                	test   %eax,%eax
80104465:	74 ed                	je     80104454 <popcli+0x34>
80104467:	fb                   	sti    
80104468:	c9                   	leave  
80104469:	c3                   	ret    
8010446a:	c7 04 24 16 77 10 80 	movl   $0x80107716,(%esp)
80104471:	e8 ea be ff ff       	call   80100360 <panic>
80104476:	c7 04 24 ff 76 10 80 	movl   $0x801076ff,(%esp)
8010447d:	e8 de be ff ff       	call   80100360 <panic>
80104482:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104490 <holding>:
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	56                   	push   %esi
80104494:	31 f6                	xor    %esi,%esi
80104496:	53                   	push   %ebx
80104497:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010449a:	e8 41 ff ff ff       	call   801043e0 <pushcli>
8010449f:	8b 03                	mov    (%ebx),%eax
801044a1:	85 c0                	test   %eax,%eax
801044a3:	74 12                	je     801044b7 <holding+0x27>
801044a5:	8b 5b 08             	mov    0x8(%ebx),%ebx
801044a8:	e8 a3 f1 ff ff       	call   80103650 <mycpu>
801044ad:	39 c3                	cmp    %eax,%ebx
801044af:	0f 94 c0             	sete   %al
801044b2:	0f b6 c0             	movzbl %al,%eax
801044b5:	89 c6                	mov    %eax,%esi
801044b7:	e8 64 ff ff ff       	call   80104420 <popcli>
801044bc:	89 f0                	mov    %esi,%eax
801044be:	5b                   	pop    %ebx
801044bf:	5e                   	pop    %esi
801044c0:	5d                   	pop    %ebp
801044c1:	c3                   	ret    
801044c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044d0 <acquire>:
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	53                   	push   %ebx
801044d4:	83 ec 14             	sub    $0x14,%esp
801044d7:	e8 04 ff ff ff       	call   801043e0 <pushcli>
801044dc:	8b 45 08             	mov    0x8(%ebp),%eax
801044df:	89 04 24             	mov    %eax,(%esp)
801044e2:	e8 a9 ff ff ff       	call   80104490 <holding>
801044e7:	85 c0                	test   %eax,%eax
801044e9:	75 3a                	jne    80104525 <acquire+0x55>
801044eb:	b9 01 00 00 00       	mov    $0x1,%ecx
801044f0:	8b 55 08             	mov    0x8(%ebp),%edx
801044f3:	89 c8                	mov    %ecx,%eax
801044f5:	f0 87 02             	lock xchg %eax,(%edx)
801044f8:	85 c0                	test   %eax,%eax
801044fa:	75 f4                	jne    801044f0 <acquire+0x20>
801044fc:	0f ae f0             	mfence 
801044ff:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104502:	e8 49 f1 ff ff       	call   80103650 <mycpu>
80104507:	89 43 08             	mov    %eax,0x8(%ebx)
8010450a:	8b 45 08             	mov    0x8(%ebp),%eax
8010450d:	83 c0 0c             	add    $0xc,%eax
80104510:	89 44 24 04          	mov    %eax,0x4(%esp)
80104514:	8d 45 08             	lea    0x8(%ebp),%eax
80104517:	89 04 24             	mov    %eax,(%esp)
8010451a:	e8 61 fe ff ff       	call   80104380 <getcallerpcs>
8010451f:	83 c4 14             	add    $0x14,%esp
80104522:	5b                   	pop    %ebx
80104523:	5d                   	pop    %ebp
80104524:	c3                   	ret    
80104525:	c7 04 24 1d 77 10 80 	movl   $0x8010771d,(%esp)
8010452c:	e8 2f be ff ff       	call   80100360 <panic>
80104531:	eb 0d                	jmp    80104540 <release>
80104533:	90                   	nop
80104534:	90                   	nop
80104535:	90                   	nop
80104536:	90                   	nop
80104537:	90                   	nop
80104538:	90                   	nop
80104539:	90                   	nop
8010453a:	90                   	nop
8010453b:	90                   	nop
8010453c:	90                   	nop
8010453d:	90                   	nop
8010453e:	90                   	nop
8010453f:	90                   	nop

80104540 <release>:
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	53                   	push   %ebx
80104544:	83 ec 14             	sub    $0x14,%esp
80104547:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010454a:	89 1c 24             	mov    %ebx,(%esp)
8010454d:	e8 3e ff ff ff       	call   80104490 <holding>
80104552:	85 c0                	test   %eax,%eax
80104554:	74 21                	je     80104577 <release+0x37>
80104556:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
8010455d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80104564:	0f ae f0             	mfence 
80104567:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010456d:	83 c4 14             	add    $0x14,%esp
80104570:	5b                   	pop    %ebx
80104571:	5d                   	pop    %ebp
80104572:	e9 a9 fe ff ff       	jmp    80104420 <popcli>
80104577:	c7 04 24 25 77 10 80 	movl   $0x80107725,(%esp)
8010457e:	e8 dd bd ff ff       	call   80100360 <panic>
80104583:	66 90                	xchg   %ax,%ax
80104585:	66 90                	xchg   %ax,%ax
80104587:	66 90                	xchg   %ax,%ax
80104589:	66 90                	xchg   %ax,%ax
8010458b:	66 90                	xchg   %ax,%ax
8010458d:	66 90                	xchg   %ax,%ax
8010458f:	90                   	nop

80104590 <memset>:
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	8b 55 08             	mov    0x8(%ebp),%edx
80104596:	57                   	push   %edi
80104597:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010459a:	53                   	push   %ebx
8010459b:	f6 c2 03             	test   $0x3,%dl
8010459e:	75 05                	jne    801045a5 <memset+0x15>
801045a0:	f6 c1 03             	test   $0x3,%cl
801045a3:	74 13                	je     801045b8 <memset+0x28>
801045a5:	89 d7                	mov    %edx,%edi
801045a7:	8b 45 0c             	mov    0xc(%ebp),%eax
801045aa:	fc                   	cld    
801045ab:	f3 aa                	rep stos %al,%es:(%edi)
801045ad:	5b                   	pop    %ebx
801045ae:	89 d0                	mov    %edx,%eax
801045b0:	5f                   	pop    %edi
801045b1:	5d                   	pop    %ebp
801045b2:	c3                   	ret    
801045b3:	90                   	nop
801045b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045b8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
801045bc:	c1 e9 02             	shr    $0x2,%ecx
801045bf:	89 f8                	mov    %edi,%eax
801045c1:	89 fb                	mov    %edi,%ebx
801045c3:	c1 e0 18             	shl    $0x18,%eax
801045c6:	c1 e3 10             	shl    $0x10,%ebx
801045c9:	09 d8                	or     %ebx,%eax
801045cb:	09 f8                	or     %edi,%eax
801045cd:	c1 e7 08             	shl    $0x8,%edi
801045d0:	09 f8                	or     %edi,%eax
801045d2:	89 d7                	mov    %edx,%edi
801045d4:	fc                   	cld    
801045d5:	f3 ab                	rep stos %eax,%es:(%edi)
801045d7:	5b                   	pop    %ebx
801045d8:	89 d0                	mov    %edx,%eax
801045da:	5f                   	pop    %edi
801045db:	5d                   	pop    %ebp
801045dc:	c3                   	ret    
801045dd:	8d 76 00             	lea    0x0(%esi),%esi

801045e0 <memcmp>:
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	8b 45 10             	mov    0x10(%ebp),%eax
801045e6:	57                   	push   %edi
801045e7:	56                   	push   %esi
801045e8:	8b 75 0c             	mov    0xc(%ebp),%esi
801045eb:	53                   	push   %ebx
801045ec:	8b 5d 08             	mov    0x8(%ebp),%ebx
801045ef:	85 c0                	test   %eax,%eax
801045f1:	8d 78 ff             	lea    -0x1(%eax),%edi
801045f4:	74 26                	je     8010461c <memcmp+0x3c>
801045f6:	0f b6 03             	movzbl (%ebx),%eax
801045f9:	31 d2                	xor    %edx,%edx
801045fb:	0f b6 0e             	movzbl (%esi),%ecx
801045fe:	38 c8                	cmp    %cl,%al
80104600:	74 16                	je     80104618 <memcmp+0x38>
80104602:	eb 24                	jmp    80104628 <memcmp+0x48>
80104604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104608:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
8010460d:	83 c2 01             	add    $0x1,%edx
80104610:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104614:	38 c8                	cmp    %cl,%al
80104616:	75 10                	jne    80104628 <memcmp+0x48>
80104618:	39 fa                	cmp    %edi,%edx
8010461a:	75 ec                	jne    80104608 <memcmp+0x28>
8010461c:	5b                   	pop    %ebx
8010461d:	31 c0                	xor    %eax,%eax
8010461f:	5e                   	pop    %esi
80104620:	5f                   	pop    %edi
80104621:	5d                   	pop    %ebp
80104622:	c3                   	ret    
80104623:	90                   	nop
80104624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104628:	5b                   	pop    %ebx
80104629:	29 c8                	sub    %ecx,%eax
8010462b:	5e                   	pop    %esi
8010462c:	5f                   	pop    %edi
8010462d:	5d                   	pop    %ebp
8010462e:	c3                   	ret    
8010462f:	90                   	nop

80104630 <memmove>:
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	57                   	push   %edi
80104634:	8b 45 08             	mov    0x8(%ebp),%eax
80104637:	56                   	push   %esi
80104638:	8b 75 0c             	mov    0xc(%ebp),%esi
8010463b:	53                   	push   %ebx
8010463c:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010463f:	39 c6                	cmp    %eax,%esi
80104641:	73 35                	jae    80104678 <memmove+0x48>
80104643:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104646:	39 c8                	cmp    %ecx,%eax
80104648:	73 2e                	jae    80104678 <memmove+0x48>
8010464a:	85 db                	test   %ebx,%ebx
8010464c:	8d 3c 18             	lea    (%eax,%ebx,1),%edi
8010464f:	8d 53 ff             	lea    -0x1(%ebx),%edx
80104652:	74 1b                	je     8010466f <memmove+0x3f>
80104654:	f7 db                	neg    %ebx
80104656:	8d 34 19             	lea    (%ecx,%ebx,1),%esi
80104659:	01 fb                	add    %edi,%ebx
8010465b:	90                   	nop
8010465c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104660:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104664:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
80104667:	83 ea 01             	sub    $0x1,%edx
8010466a:	83 fa ff             	cmp    $0xffffffff,%edx
8010466d:	75 f1                	jne    80104660 <memmove+0x30>
8010466f:	5b                   	pop    %ebx
80104670:	5e                   	pop    %esi
80104671:	5f                   	pop    %edi
80104672:	5d                   	pop    %ebp
80104673:	c3                   	ret    
80104674:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104678:	31 d2                	xor    %edx,%edx
8010467a:	85 db                	test   %ebx,%ebx
8010467c:	74 f1                	je     8010466f <memmove+0x3f>
8010467e:	66 90                	xchg   %ax,%ax
80104680:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104684:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104687:	83 c2 01             	add    $0x1,%edx
8010468a:	39 da                	cmp    %ebx,%edx
8010468c:	75 f2                	jne    80104680 <memmove+0x50>
8010468e:	5b                   	pop    %ebx
8010468f:	5e                   	pop    %esi
80104690:	5f                   	pop    %edi
80104691:	5d                   	pop    %ebp
80104692:	c3                   	ret    
80104693:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046a0 <memcpy>:
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	5d                   	pop    %ebp
801046a4:	eb 8a                	jmp    80104630 <memmove>
801046a6:	8d 76 00             	lea    0x0(%esi),%esi
801046a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046b0 <strncmp>:
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	56                   	push   %esi
801046b4:	8b 75 10             	mov    0x10(%ebp),%esi
801046b7:	53                   	push   %ebx
801046b8:	8b 4d 08             	mov    0x8(%ebp),%ecx
801046bb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801046be:	85 f6                	test   %esi,%esi
801046c0:	74 30                	je     801046f2 <strncmp+0x42>
801046c2:	0f b6 01             	movzbl (%ecx),%eax
801046c5:	84 c0                	test   %al,%al
801046c7:	74 2f                	je     801046f8 <strncmp+0x48>
801046c9:	0f b6 13             	movzbl (%ebx),%edx
801046cc:	38 d0                	cmp    %dl,%al
801046ce:	75 46                	jne    80104716 <strncmp+0x66>
801046d0:	8d 51 01             	lea    0x1(%ecx),%edx
801046d3:	01 ce                	add    %ecx,%esi
801046d5:	eb 14                	jmp    801046eb <strncmp+0x3b>
801046d7:	90                   	nop
801046d8:	0f b6 02             	movzbl (%edx),%eax
801046db:	84 c0                	test   %al,%al
801046dd:	74 31                	je     80104710 <strncmp+0x60>
801046df:	0f b6 19             	movzbl (%ecx),%ebx
801046e2:	83 c2 01             	add    $0x1,%edx
801046e5:	38 d8                	cmp    %bl,%al
801046e7:	75 17                	jne    80104700 <strncmp+0x50>
801046e9:	89 cb                	mov    %ecx,%ebx
801046eb:	39 f2                	cmp    %esi,%edx
801046ed:	8d 4b 01             	lea    0x1(%ebx),%ecx
801046f0:	75 e6                	jne    801046d8 <strncmp+0x28>
801046f2:	5b                   	pop    %ebx
801046f3:	31 c0                	xor    %eax,%eax
801046f5:	5e                   	pop    %esi
801046f6:	5d                   	pop    %ebp
801046f7:	c3                   	ret    
801046f8:	0f b6 1b             	movzbl (%ebx),%ebx
801046fb:	31 c0                	xor    %eax,%eax
801046fd:	8d 76 00             	lea    0x0(%esi),%esi
80104700:	0f b6 d3             	movzbl %bl,%edx
80104703:	29 d0                	sub    %edx,%eax
80104705:	5b                   	pop    %ebx
80104706:	5e                   	pop    %esi
80104707:	5d                   	pop    %ebp
80104708:	c3                   	ret    
80104709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104710:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
80104714:	eb ea                	jmp    80104700 <strncmp+0x50>
80104716:	89 d3                	mov    %edx,%ebx
80104718:	eb e6                	jmp    80104700 <strncmp+0x50>
8010471a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104720 <strncpy>:
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	8b 45 08             	mov    0x8(%ebp),%eax
80104726:	56                   	push   %esi
80104727:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010472a:	53                   	push   %ebx
8010472b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010472e:	89 c2                	mov    %eax,%edx
80104730:	eb 19                	jmp    8010474b <strncpy+0x2b>
80104732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104738:	83 c3 01             	add    $0x1,%ebx
8010473b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
8010473f:	83 c2 01             	add    $0x1,%edx
80104742:	84 c9                	test   %cl,%cl
80104744:	88 4a ff             	mov    %cl,-0x1(%edx)
80104747:	74 09                	je     80104752 <strncpy+0x32>
80104749:	89 f1                	mov    %esi,%ecx
8010474b:	85 c9                	test   %ecx,%ecx
8010474d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104750:	7f e6                	jg     80104738 <strncpy+0x18>
80104752:	31 c9                	xor    %ecx,%ecx
80104754:	85 f6                	test   %esi,%esi
80104756:	7e 0f                	jle    80104767 <strncpy+0x47>
80104758:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
8010475c:	89 f3                	mov    %esi,%ebx
8010475e:	83 c1 01             	add    $0x1,%ecx
80104761:	29 cb                	sub    %ecx,%ebx
80104763:	85 db                	test   %ebx,%ebx
80104765:	7f f1                	jg     80104758 <strncpy+0x38>
80104767:	5b                   	pop    %ebx
80104768:	5e                   	pop    %esi
80104769:	5d                   	pop    %ebp
8010476a:	c3                   	ret    
8010476b:	90                   	nop
8010476c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104770 <safestrcpy>:
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104776:	56                   	push   %esi
80104777:	8b 45 08             	mov    0x8(%ebp),%eax
8010477a:	53                   	push   %ebx
8010477b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010477e:	85 c9                	test   %ecx,%ecx
80104780:	7e 26                	jle    801047a8 <safestrcpy+0x38>
80104782:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104786:	89 c1                	mov    %eax,%ecx
80104788:	eb 17                	jmp    801047a1 <safestrcpy+0x31>
8010478a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104790:	83 c2 01             	add    $0x1,%edx
80104793:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104797:	83 c1 01             	add    $0x1,%ecx
8010479a:	84 db                	test   %bl,%bl
8010479c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010479f:	74 04                	je     801047a5 <safestrcpy+0x35>
801047a1:	39 f2                	cmp    %esi,%edx
801047a3:	75 eb                	jne    80104790 <safestrcpy+0x20>
801047a5:	c6 01 00             	movb   $0x0,(%ecx)
801047a8:	5b                   	pop    %ebx
801047a9:	5e                   	pop    %esi
801047aa:	5d                   	pop    %ebp
801047ab:	c3                   	ret    
801047ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047b0 <strlen>:
801047b0:	55                   	push   %ebp
801047b1:	31 c0                	xor    %eax,%eax
801047b3:	89 e5                	mov    %esp,%ebp
801047b5:	8b 55 08             	mov    0x8(%ebp),%edx
801047b8:	80 3a 00             	cmpb   $0x0,(%edx)
801047bb:	74 0c                	je     801047c9 <strlen+0x19>
801047bd:	8d 76 00             	lea    0x0(%esi),%esi
801047c0:	83 c0 01             	add    $0x1,%eax
801047c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801047c7:	75 f7                	jne    801047c0 <strlen+0x10>
801047c9:	5d                   	pop    %ebp
801047ca:	c3                   	ret    

801047cb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801047cb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801047cf:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801047d3:	55                   	push   %ebp
  pushl %ebx
801047d4:	53                   	push   %ebx
  pushl %esi
801047d5:	56                   	push   %esi
  pushl %edi
801047d6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801047d7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801047d9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801047db:	5f                   	pop    %edi
  popl %esi
801047dc:	5e                   	pop    %esi
  popl %ebx
801047dd:	5b                   	pop    %ebx
  popl %ebp
801047de:	5d                   	pop    %ebp
  ret
801047df:	c3                   	ret    

801047e0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	53                   	push   %ebx
801047e4:	83 ec 04             	sub    $0x4,%esp
801047e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801047ea:	e8 01 ef ff ff       	call   801036f0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801047ef:	8b 00                	mov    (%eax),%eax
801047f1:	39 d8                	cmp    %ebx,%eax
801047f3:	76 1b                	jbe    80104810 <fetchint+0x30>
801047f5:	8d 53 04             	lea    0x4(%ebx),%edx
801047f8:	39 d0                	cmp    %edx,%eax
801047fa:	72 14                	jb     80104810 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801047fc:	8b 45 0c             	mov    0xc(%ebp),%eax
801047ff:	8b 13                	mov    (%ebx),%edx
80104801:	89 10                	mov    %edx,(%eax)
  return 0;
80104803:	31 c0                	xor    %eax,%eax
}
80104805:	83 c4 04             	add    $0x4,%esp
80104808:	5b                   	pop    %ebx
80104809:	5d                   	pop    %ebp
8010480a:	c3                   	ret    
8010480b:	90                   	nop
8010480c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104810:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104815:	eb ee                	jmp    80104805 <fetchint+0x25>
80104817:	89 f6                	mov    %esi,%esi
80104819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104820 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	53                   	push   %ebx
80104824:	83 ec 04             	sub    $0x4,%esp
80104827:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010482a:	e8 c1 ee ff ff       	call   801036f0 <myproc>

  if(addr >= curproc->sz)
8010482f:	39 18                	cmp    %ebx,(%eax)
80104831:	76 26                	jbe    80104859 <fetchstr+0x39>
    return -1;
  *pp = (char*)addr;
80104833:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104836:	89 da                	mov    %ebx,%edx
80104838:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
8010483a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
8010483c:	39 c3                	cmp    %eax,%ebx
8010483e:	73 19                	jae    80104859 <fetchstr+0x39>
    if(*s == 0)
80104840:	80 3b 00             	cmpb   $0x0,(%ebx)
80104843:	75 0d                	jne    80104852 <fetchstr+0x32>
80104845:	eb 21                	jmp    80104868 <fetchstr+0x48>
80104847:	90                   	nop
80104848:	80 3a 00             	cmpb   $0x0,(%edx)
8010484b:	90                   	nop
8010484c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104850:	74 16                	je     80104868 <fetchstr+0x48>
  for(s = *pp; s < ep; s++){
80104852:	83 c2 01             	add    $0x1,%edx
80104855:	39 d0                	cmp    %edx,%eax
80104857:	77 ef                	ja     80104848 <fetchstr+0x28>
      return s - *pp;
  }
  return -1;
}
80104859:	83 c4 04             	add    $0x4,%esp
    return -1;
8010485c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104861:	5b                   	pop    %ebx
80104862:	5d                   	pop    %ebp
80104863:	c3                   	ret    
80104864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104868:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
8010486b:	89 d0                	mov    %edx,%eax
8010486d:	29 d8                	sub    %ebx,%eax
}
8010486f:	5b                   	pop    %ebx
80104870:	5d                   	pop    %ebp
80104871:	c3                   	ret    
80104872:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104879:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104880 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	56                   	push   %esi
80104884:	8b 75 0c             	mov    0xc(%ebp),%esi
80104887:	53                   	push   %ebx
80104888:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010488b:	e8 60 ee ff ff       	call   801036f0 <myproc>
80104890:	89 75 0c             	mov    %esi,0xc(%ebp)
80104893:	8b 40 18             	mov    0x18(%eax),%eax
80104896:	8b 40 44             	mov    0x44(%eax),%eax
80104899:	8d 44 98 04          	lea    0x4(%eax,%ebx,4),%eax
8010489d:	89 45 08             	mov    %eax,0x8(%ebp)
}
801048a0:	5b                   	pop    %ebx
801048a1:	5e                   	pop    %esi
801048a2:	5d                   	pop    %ebp
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801048a3:	e9 38 ff ff ff       	jmp    801047e0 <fetchint>
801048a8:	90                   	nop
801048a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801048b0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801048b0:	55                   	push   %ebp
801048b1:	89 e5                	mov    %esp,%ebp
801048b3:	56                   	push   %esi
801048b4:	53                   	push   %ebx
801048b5:	83 ec 20             	sub    $0x20,%esp
801048b8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801048bb:	e8 30 ee ff ff       	call   801036f0 <myproc>
801048c0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
801048c2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801048c5:	89 44 24 04          	mov    %eax,0x4(%esp)
801048c9:	8b 45 08             	mov    0x8(%ebp),%eax
801048cc:	89 04 24             	mov    %eax,(%esp)
801048cf:	e8 ac ff ff ff       	call   80104880 <argint>
801048d4:	85 c0                	test   %eax,%eax
801048d6:	78 28                	js     80104900 <argptr+0x50>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801048d8:	85 db                	test   %ebx,%ebx
801048da:	78 24                	js     80104900 <argptr+0x50>
801048dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801048df:	8b 06                	mov    (%esi),%eax
801048e1:	39 c2                	cmp    %eax,%edx
801048e3:	73 1b                	jae    80104900 <argptr+0x50>
801048e5:	01 d3                	add    %edx,%ebx
801048e7:	39 d8                	cmp    %ebx,%eax
801048e9:	72 15                	jb     80104900 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801048eb:	8b 45 0c             	mov    0xc(%ebp),%eax
801048ee:	89 10                	mov    %edx,(%eax)
  return 0;
}
801048f0:	83 c4 20             	add    $0x20,%esp
  return 0;
801048f3:	31 c0                	xor    %eax,%eax
}
801048f5:	5b                   	pop    %ebx
801048f6:	5e                   	pop    %esi
801048f7:	5d                   	pop    %ebp
801048f8:	c3                   	ret    
801048f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104900:	83 c4 20             	add    $0x20,%esp
    return -1;
80104903:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104908:	5b                   	pop    %ebx
80104909:	5e                   	pop    %esi
8010490a:	5d                   	pop    %ebp
8010490b:	c3                   	ret    
8010490c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104910 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104916:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104919:	89 44 24 04          	mov    %eax,0x4(%esp)
8010491d:	8b 45 08             	mov    0x8(%ebp),%eax
80104920:	89 04 24             	mov    %eax,(%esp)
80104923:	e8 58 ff ff ff       	call   80104880 <argint>
80104928:	85 c0                	test   %eax,%eax
8010492a:	78 14                	js     80104940 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
8010492c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010492f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104933:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104936:	89 04 24             	mov    %eax,(%esp)
80104939:	e8 e2 fe ff ff       	call   80104820 <fetchstr>
}
8010493e:	c9                   	leave  
8010493f:	c3                   	ret    
    return -1;
80104940:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104945:	c9                   	leave  
80104946:	c3                   	ret    
80104947:	89 f6                	mov    %esi,%esi
80104949:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104950 <syscall>:
[SYS_set_prior] sys_set_prior, //new for lab2
};

void
syscall(void)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	56                   	push   %esi
80104954:	53                   	push   %ebx
80104955:	83 ec 10             	sub    $0x10,%esp
  int num;
  struct proc *curproc = myproc();
80104958:	e8 93 ed ff ff       	call   801036f0 <myproc>

  num = curproc->tf->eax;
8010495d:	8b 70 18             	mov    0x18(%eax),%esi
  struct proc *curproc = myproc();
80104960:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
80104962:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104965:	8d 50 ff             	lea    -0x1(%eax),%edx
80104968:	83 fa 17             	cmp    $0x17,%edx
8010496b:	77 1b                	ja     80104988 <syscall+0x38>
8010496d:	8b 14 85 60 77 10 80 	mov    -0x7fef88a0(,%eax,4),%edx
80104974:	85 d2                	test   %edx,%edx
80104976:	74 10                	je     80104988 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104978:	ff d2                	call   *%edx
8010497a:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
8010497d:	83 c4 10             	add    $0x10,%esp
80104980:	5b                   	pop    %ebx
80104981:	5e                   	pop    %esi
80104982:	5d                   	pop    %ebp
80104983:	c3                   	ret    
80104984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104988:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
8010498c:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010498f:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
80104993:	8b 43 10             	mov    0x10(%ebx),%eax
80104996:	c7 04 24 2d 77 10 80 	movl   $0x8010772d,(%esp)
8010499d:	89 44 24 04          	mov    %eax,0x4(%esp)
801049a1:	e8 aa bc ff ff       	call   80100650 <cprintf>
    curproc->tf->eax = -1;
801049a6:	8b 43 18             	mov    0x18(%ebx),%eax
801049a9:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801049b0:	83 c4 10             	add    $0x10,%esp
801049b3:	5b                   	pop    %ebx
801049b4:	5e                   	pop    %esi
801049b5:	5d                   	pop    %ebp
801049b6:	c3                   	ret    
801049b7:	66 90                	xchg   %ax,%ax
801049b9:	66 90                	xchg   %ax,%ax
801049bb:	66 90                	xchg   %ax,%ax
801049bd:	66 90                	xchg   %ax,%ax
801049bf:	90                   	nop

801049c0 <fdalloc>:
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	53                   	push   %ebx
801049c4:	89 c3                	mov    %eax,%ebx
801049c6:	83 ec 04             	sub    $0x4,%esp
801049c9:	e8 22 ed ff ff       	call   801036f0 <myproc>
801049ce:	31 d2                	xor    %edx,%edx
801049d0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801049d4:	85 c9                	test   %ecx,%ecx
801049d6:	74 18                	je     801049f0 <fdalloc+0x30>
801049d8:	83 c2 01             	add    $0x1,%edx
801049db:	83 fa 10             	cmp    $0x10,%edx
801049de:	75 f0                	jne    801049d0 <fdalloc+0x10>
801049e0:	83 c4 04             	add    $0x4,%esp
801049e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049e8:	5b                   	pop    %ebx
801049e9:	5d                   	pop    %ebp
801049ea:	c3                   	ret    
801049eb:	90                   	nop
801049ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049f0:	89 5c 90 28          	mov    %ebx,0x28(%eax,%edx,4)
801049f4:	83 c4 04             	add    $0x4,%esp
801049f7:	89 d0                	mov    %edx,%eax
801049f9:	5b                   	pop    %ebx
801049fa:	5d                   	pop    %ebp
801049fb:	c3                   	ret    
801049fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a00 <create>:
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	57                   	push   %edi
80104a04:	56                   	push   %esi
80104a05:	53                   	push   %ebx
80104a06:	83 ec 3c             	sub    $0x3c,%esp
80104a09:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104a0c:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104a0f:	8d 5d da             	lea    -0x26(%ebp),%ebx
80104a12:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104a16:	89 04 24             	mov    %eax,(%esp)
80104a19:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104a1c:	89 4d cc             	mov    %ecx,-0x34(%ebp)
80104a1f:	e8 fc d4 ff ff       	call   80101f20 <nameiparent>
80104a24:	85 c0                	test   %eax,%eax
80104a26:	89 c7                	mov    %eax,%edi
80104a28:	0f 84 da 00 00 00    	je     80104b08 <create+0x108>
80104a2e:	89 04 24             	mov    %eax,(%esp)
80104a31:	e8 7a cc ff ff       	call   801016b0 <ilock>
80104a36:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80104a3d:	00 
80104a3e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104a42:	89 3c 24             	mov    %edi,(%esp)
80104a45:	e8 76 d1 ff ff       	call   80101bc0 <dirlookup>
80104a4a:	85 c0                	test   %eax,%eax
80104a4c:	89 c6                	mov    %eax,%esi
80104a4e:	74 40                	je     80104a90 <create+0x90>
80104a50:	89 3c 24             	mov    %edi,(%esp)
80104a53:	e8 b8 ce ff ff       	call   80101910 <iunlockput>
80104a58:	89 34 24             	mov    %esi,(%esp)
80104a5b:	e8 50 cc ff ff       	call   801016b0 <ilock>
80104a60:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104a65:	75 11                	jne    80104a78 <create+0x78>
80104a67:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104a6c:	89 f0                	mov    %esi,%eax
80104a6e:	75 08                	jne    80104a78 <create+0x78>
80104a70:	83 c4 3c             	add    $0x3c,%esp
80104a73:	5b                   	pop    %ebx
80104a74:	5e                   	pop    %esi
80104a75:	5f                   	pop    %edi
80104a76:	5d                   	pop    %ebp
80104a77:	c3                   	ret    
80104a78:	89 34 24             	mov    %esi,(%esp)
80104a7b:	e8 90 ce ff ff       	call   80101910 <iunlockput>
80104a80:	83 c4 3c             	add    $0x3c,%esp
80104a83:	31 c0                	xor    %eax,%eax
80104a85:	5b                   	pop    %ebx
80104a86:	5e                   	pop    %esi
80104a87:	5f                   	pop    %edi
80104a88:	5d                   	pop    %ebp
80104a89:	c3                   	ret    
80104a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a90:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104a94:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a98:	8b 07                	mov    (%edi),%eax
80104a9a:	89 04 24             	mov    %eax,(%esp)
80104a9d:	e8 7e ca ff ff       	call   80101520 <ialloc>
80104aa2:	85 c0                	test   %eax,%eax
80104aa4:	89 c6                	mov    %eax,%esi
80104aa6:	0f 84 bf 00 00 00    	je     80104b6b <create+0x16b>
80104aac:	89 04 24             	mov    %eax,(%esp)
80104aaf:	e8 fc cb ff ff       	call   801016b0 <ilock>
80104ab4:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104ab8:	66 89 46 52          	mov    %ax,0x52(%esi)
80104abc:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104ac0:	66 89 46 54          	mov    %ax,0x54(%esi)
80104ac4:	b8 01 00 00 00       	mov    $0x1,%eax
80104ac9:	66 89 46 56          	mov    %ax,0x56(%esi)
80104acd:	89 34 24             	mov    %esi,(%esp)
80104ad0:	e8 1b cb ff ff       	call   801015f0 <iupdate>
80104ad5:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104ada:	74 34                	je     80104b10 <create+0x110>
80104adc:	8b 46 04             	mov    0x4(%esi),%eax
80104adf:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104ae3:	89 3c 24             	mov    %edi,(%esp)
80104ae6:	89 44 24 08          	mov    %eax,0x8(%esp)
80104aea:	e8 31 d3 ff ff       	call   80101e20 <dirlink>
80104aef:	85 c0                	test   %eax,%eax
80104af1:	78 6c                	js     80104b5f <create+0x15f>
80104af3:	89 3c 24             	mov    %edi,(%esp)
80104af6:	e8 15 ce ff ff       	call   80101910 <iunlockput>
80104afb:	83 c4 3c             	add    $0x3c,%esp
80104afe:	89 f0                	mov    %esi,%eax
80104b00:	5b                   	pop    %ebx
80104b01:	5e                   	pop    %esi
80104b02:	5f                   	pop    %edi
80104b03:	5d                   	pop    %ebp
80104b04:	c3                   	ret    
80104b05:	8d 76 00             	lea    0x0(%esi),%esi
80104b08:	31 c0                	xor    %eax,%eax
80104b0a:	e9 61 ff ff ff       	jmp    80104a70 <create+0x70>
80104b0f:	90                   	nop
80104b10:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
80104b15:	89 3c 24             	mov    %edi,(%esp)
80104b18:	e8 d3 ca ff ff       	call   801015f0 <iupdate>
80104b1d:	8b 46 04             	mov    0x4(%esi),%eax
80104b20:	c7 44 24 04 e0 77 10 	movl   $0x801077e0,0x4(%esp)
80104b27:	80 
80104b28:	89 34 24             	mov    %esi,(%esp)
80104b2b:	89 44 24 08          	mov    %eax,0x8(%esp)
80104b2f:	e8 ec d2 ff ff       	call   80101e20 <dirlink>
80104b34:	85 c0                	test   %eax,%eax
80104b36:	78 1b                	js     80104b53 <create+0x153>
80104b38:	8b 47 04             	mov    0x4(%edi),%eax
80104b3b:	c7 44 24 04 df 77 10 	movl   $0x801077df,0x4(%esp)
80104b42:	80 
80104b43:	89 34 24             	mov    %esi,(%esp)
80104b46:	89 44 24 08          	mov    %eax,0x8(%esp)
80104b4a:	e8 d1 d2 ff ff       	call   80101e20 <dirlink>
80104b4f:	85 c0                	test   %eax,%eax
80104b51:	79 89                	jns    80104adc <create+0xdc>
80104b53:	c7 04 24 d3 77 10 80 	movl   $0x801077d3,(%esp)
80104b5a:	e8 01 b8 ff ff       	call   80100360 <panic>
80104b5f:	c7 04 24 e2 77 10 80 	movl   $0x801077e2,(%esp)
80104b66:	e8 f5 b7 ff ff       	call   80100360 <panic>
80104b6b:	c7 04 24 c4 77 10 80 	movl   $0x801077c4,(%esp)
80104b72:	e8 e9 b7 ff ff       	call   80100360 <panic>
80104b77:	89 f6                	mov    %esi,%esi
80104b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b80 <argfd.constprop.0>:
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	56                   	push   %esi
80104b84:	89 c6                	mov    %eax,%esi
80104b86:	53                   	push   %ebx
80104b87:	89 d3                	mov    %edx,%ebx
80104b89:	83 ec 20             	sub    $0x20,%esp
80104b8c:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b8f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b93:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104b9a:	e8 e1 fc ff ff       	call   80104880 <argint>
80104b9f:	85 c0                	test   %eax,%eax
80104ba1:	78 2d                	js     80104bd0 <argfd.constprop.0+0x50>
80104ba3:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104ba7:	77 27                	ja     80104bd0 <argfd.constprop.0+0x50>
80104ba9:	e8 42 eb ff ff       	call   801036f0 <myproc>
80104bae:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104bb1:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104bb5:	85 c0                	test   %eax,%eax
80104bb7:	74 17                	je     80104bd0 <argfd.constprop.0+0x50>
80104bb9:	85 f6                	test   %esi,%esi
80104bbb:	74 02                	je     80104bbf <argfd.constprop.0+0x3f>
80104bbd:	89 16                	mov    %edx,(%esi)
80104bbf:	85 db                	test   %ebx,%ebx
80104bc1:	74 1d                	je     80104be0 <argfd.constprop.0+0x60>
80104bc3:	89 03                	mov    %eax,(%ebx)
80104bc5:	31 c0                	xor    %eax,%eax
80104bc7:	83 c4 20             	add    $0x20,%esp
80104bca:	5b                   	pop    %ebx
80104bcb:	5e                   	pop    %esi
80104bcc:	5d                   	pop    %ebp
80104bcd:	c3                   	ret    
80104bce:	66 90                	xchg   %ax,%ax
80104bd0:	83 c4 20             	add    $0x20,%esp
80104bd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bd8:	5b                   	pop    %ebx
80104bd9:	5e                   	pop    %esi
80104bda:	5d                   	pop    %ebp
80104bdb:	c3                   	ret    
80104bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104be0:	31 c0                	xor    %eax,%eax
80104be2:	eb e3                	jmp    80104bc7 <argfd.constprop.0+0x47>
80104be4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104bea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104bf0 <sys_dup>:
80104bf0:	55                   	push   %ebp
80104bf1:	31 c0                	xor    %eax,%eax
80104bf3:	89 e5                	mov    %esp,%ebp
80104bf5:	53                   	push   %ebx
80104bf6:	83 ec 24             	sub    $0x24,%esp
80104bf9:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104bfc:	e8 7f ff ff ff       	call   80104b80 <argfd.constprop.0>
80104c01:	85 c0                	test   %eax,%eax
80104c03:	78 23                	js     80104c28 <sys_dup+0x38>
80104c05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c08:	e8 b3 fd ff ff       	call   801049c0 <fdalloc>
80104c0d:	85 c0                	test   %eax,%eax
80104c0f:	89 c3                	mov    %eax,%ebx
80104c11:	78 15                	js     80104c28 <sys_dup+0x38>
80104c13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c16:	89 04 24             	mov    %eax,(%esp)
80104c19:	e8 c2 c1 ff ff       	call   80100de0 <filedup>
80104c1e:	89 d8                	mov    %ebx,%eax
80104c20:	83 c4 24             	add    $0x24,%esp
80104c23:	5b                   	pop    %ebx
80104c24:	5d                   	pop    %ebp
80104c25:	c3                   	ret    
80104c26:	66 90                	xchg   %ax,%ax
80104c28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c2d:	eb f1                	jmp    80104c20 <sys_dup+0x30>
80104c2f:	90                   	nop

80104c30 <sys_read>:
80104c30:	55                   	push   %ebp
80104c31:	31 c0                	xor    %eax,%eax
80104c33:	89 e5                	mov    %esp,%ebp
80104c35:	83 ec 28             	sub    $0x28,%esp
80104c38:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c3b:	e8 40 ff ff ff       	call   80104b80 <argfd.constprop.0>
80104c40:	85 c0                	test   %eax,%eax
80104c42:	78 54                	js     80104c98 <sys_read+0x68>
80104c44:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c47:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c4b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104c52:	e8 29 fc ff ff       	call   80104880 <argint>
80104c57:	85 c0                	test   %eax,%eax
80104c59:	78 3d                	js     80104c98 <sys_read+0x68>
80104c5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c5e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104c65:	89 44 24 08          	mov    %eax,0x8(%esp)
80104c69:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c6c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c70:	e8 3b fc ff ff       	call   801048b0 <argptr>
80104c75:	85 c0                	test   %eax,%eax
80104c77:	78 1f                	js     80104c98 <sys_read+0x68>
80104c79:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104c7c:	89 44 24 08          	mov    %eax,0x8(%esp)
80104c80:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c83:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c87:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104c8a:	89 04 24             	mov    %eax,(%esp)
80104c8d:	e8 ae c2 ff ff       	call   80100f40 <fileread>
80104c92:	c9                   	leave  
80104c93:	c3                   	ret    
80104c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c9d:	c9                   	leave  
80104c9e:	c3                   	ret    
80104c9f:	90                   	nop

80104ca0 <sys_write>:
80104ca0:	55                   	push   %ebp
80104ca1:	31 c0                	xor    %eax,%eax
80104ca3:	89 e5                	mov    %esp,%ebp
80104ca5:	83 ec 28             	sub    $0x28,%esp
80104ca8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104cab:	e8 d0 fe ff ff       	call   80104b80 <argfd.constprop.0>
80104cb0:	85 c0                	test   %eax,%eax
80104cb2:	78 54                	js     80104d08 <sys_write+0x68>
80104cb4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104cb7:	89 44 24 04          	mov    %eax,0x4(%esp)
80104cbb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104cc2:	e8 b9 fb ff ff       	call   80104880 <argint>
80104cc7:	85 c0                	test   %eax,%eax
80104cc9:	78 3d                	js     80104d08 <sys_write+0x68>
80104ccb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104cce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104cd5:	89 44 24 08          	mov    %eax,0x8(%esp)
80104cd9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cdc:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ce0:	e8 cb fb ff ff       	call   801048b0 <argptr>
80104ce5:	85 c0                	test   %eax,%eax
80104ce7:	78 1f                	js     80104d08 <sys_write+0x68>
80104ce9:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104cec:	89 44 24 08          	mov    %eax,0x8(%esp)
80104cf0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cf3:	89 44 24 04          	mov    %eax,0x4(%esp)
80104cf7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104cfa:	89 04 24             	mov    %eax,(%esp)
80104cfd:	e8 de c2 ff ff       	call   80100fe0 <filewrite>
80104d02:	c9                   	leave  
80104d03:	c3                   	ret    
80104d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d0d:	c9                   	leave  
80104d0e:	c3                   	ret    
80104d0f:	90                   	nop

80104d10 <sys_close>:
80104d10:	55                   	push   %ebp
80104d11:	89 e5                	mov    %esp,%ebp
80104d13:	83 ec 28             	sub    $0x28,%esp
80104d16:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104d19:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d1c:	e8 5f fe ff ff       	call   80104b80 <argfd.constprop.0>
80104d21:	85 c0                	test   %eax,%eax
80104d23:	78 23                	js     80104d48 <sys_close+0x38>
80104d25:	e8 c6 e9 ff ff       	call   801036f0 <myproc>
80104d2a:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104d2d:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104d34:	00 
80104d35:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d38:	89 04 24             	mov    %eax,(%esp)
80104d3b:	e8 f0 c0 ff ff       	call   80100e30 <fileclose>
80104d40:	31 c0                	xor    %eax,%eax
80104d42:	c9                   	leave  
80104d43:	c3                   	ret    
80104d44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d4d:	c9                   	leave  
80104d4e:	c3                   	ret    
80104d4f:	90                   	nop

80104d50 <sys_fstat>:
80104d50:	55                   	push   %ebp
80104d51:	31 c0                	xor    %eax,%eax
80104d53:	89 e5                	mov    %esp,%ebp
80104d55:	83 ec 28             	sub    $0x28,%esp
80104d58:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104d5b:	e8 20 fe ff ff       	call   80104b80 <argfd.constprop.0>
80104d60:	85 c0                	test   %eax,%eax
80104d62:	78 34                	js     80104d98 <sys_fstat+0x48>
80104d64:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d67:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80104d6e:	00 
80104d6f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104d73:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104d7a:	e8 31 fb ff ff       	call   801048b0 <argptr>
80104d7f:	85 c0                	test   %eax,%eax
80104d81:	78 15                	js     80104d98 <sys_fstat+0x48>
80104d83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d86:	89 44 24 04          	mov    %eax,0x4(%esp)
80104d8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104d8d:	89 04 24             	mov    %eax,(%esp)
80104d90:	e8 5b c1 ff ff       	call   80100ef0 <filestat>
80104d95:	c9                   	leave  
80104d96:	c3                   	ret    
80104d97:	90                   	nop
80104d98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d9d:	c9                   	leave  
80104d9e:	c3                   	ret    
80104d9f:	90                   	nop

80104da0 <sys_link>:
80104da0:	55                   	push   %ebp
80104da1:	89 e5                	mov    %esp,%ebp
80104da3:	57                   	push   %edi
80104da4:	56                   	push   %esi
80104da5:	53                   	push   %ebx
80104da6:	83 ec 3c             	sub    $0x3c,%esp
80104da9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104dac:	89 44 24 04          	mov    %eax,0x4(%esp)
80104db0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104db7:	e8 54 fb ff ff       	call   80104910 <argstr>
80104dbc:	85 c0                	test   %eax,%eax
80104dbe:	0f 88 e6 00 00 00    	js     80104eaa <sys_link+0x10a>
80104dc4:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104dc7:	89 44 24 04          	mov    %eax,0x4(%esp)
80104dcb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104dd2:	e8 39 fb ff ff       	call   80104910 <argstr>
80104dd7:	85 c0                	test   %eax,%eax
80104dd9:	0f 88 cb 00 00 00    	js     80104eaa <sys_link+0x10a>
80104ddf:	e8 2c dd ff ff       	call   80102b10 <begin_op>
80104de4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80104de7:	89 04 24             	mov    %eax,(%esp)
80104dea:	e8 11 d1 ff ff       	call   80101f00 <namei>
80104def:	85 c0                	test   %eax,%eax
80104df1:	89 c3                	mov    %eax,%ebx
80104df3:	0f 84 ac 00 00 00    	je     80104ea5 <sys_link+0x105>
80104df9:	89 04 24             	mov    %eax,(%esp)
80104dfc:	e8 af c8 ff ff       	call   801016b0 <ilock>
80104e01:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104e06:	0f 84 91 00 00 00    	je     80104e9d <sys_link+0xfd>
80104e0c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80104e11:	8d 7d da             	lea    -0x26(%ebp),%edi
80104e14:	89 1c 24             	mov    %ebx,(%esp)
80104e17:	e8 d4 c7 ff ff       	call   801015f0 <iupdate>
80104e1c:	89 1c 24             	mov    %ebx,(%esp)
80104e1f:	e8 6c c9 ff ff       	call   80101790 <iunlock>
80104e24:	8b 45 d0             	mov    -0x30(%ebp),%eax
80104e27:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104e2b:	89 04 24             	mov    %eax,(%esp)
80104e2e:	e8 ed d0 ff ff       	call   80101f20 <nameiparent>
80104e33:	85 c0                	test   %eax,%eax
80104e35:	89 c6                	mov    %eax,%esi
80104e37:	74 4f                	je     80104e88 <sys_link+0xe8>
80104e39:	89 04 24             	mov    %eax,(%esp)
80104e3c:	e8 6f c8 ff ff       	call   801016b0 <ilock>
80104e41:	8b 03                	mov    (%ebx),%eax
80104e43:	39 06                	cmp    %eax,(%esi)
80104e45:	75 39                	jne    80104e80 <sys_link+0xe0>
80104e47:	8b 43 04             	mov    0x4(%ebx),%eax
80104e4a:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104e4e:	89 34 24             	mov    %esi,(%esp)
80104e51:	89 44 24 08          	mov    %eax,0x8(%esp)
80104e55:	e8 c6 cf ff ff       	call   80101e20 <dirlink>
80104e5a:	85 c0                	test   %eax,%eax
80104e5c:	78 22                	js     80104e80 <sys_link+0xe0>
80104e5e:	89 34 24             	mov    %esi,(%esp)
80104e61:	e8 aa ca ff ff       	call   80101910 <iunlockput>
80104e66:	89 1c 24             	mov    %ebx,(%esp)
80104e69:	e8 62 c9 ff ff       	call   801017d0 <iput>
80104e6e:	e8 0d dd ff ff       	call   80102b80 <end_op>
80104e73:	83 c4 3c             	add    $0x3c,%esp
80104e76:	31 c0                	xor    %eax,%eax
80104e78:	5b                   	pop    %ebx
80104e79:	5e                   	pop    %esi
80104e7a:	5f                   	pop    %edi
80104e7b:	5d                   	pop    %ebp
80104e7c:	c3                   	ret    
80104e7d:	8d 76 00             	lea    0x0(%esi),%esi
80104e80:	89 34 24             	mov    %esi,(%esp)
80104e83:	e8 88 ca ff ff       	call   80101910 <iunlockput>
80104e88:	89 1c 24             	mov    %ebx,(%esp)
80104e8b:	e8 20 c8 ff ff       	call   801016b0 <ilock>
80104e90:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80104e95:	89 1c 24             	mov    %ebx,(%esp)
80104e98:	e8 53 c7 ff ff       	call   801015f0 <iupdate>
80104e9d:	89 1c 24             	mov    %ebx,(%esp)
80104ea0:	e8 6b ca ff ff       	call   80101910 <iunlockput>
80104ea5:	e8 d6 dc ff ff       	call   80102b80 <end_op>
80104eaa:	83 c4 3c             	add    $0x3c,%esp
80104ead:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104eb2:	5b                   	pop    %ebx
80104eb3:	5e                   	pop    %esi
80104eb4:	5f                   	pop    %edi
80104eb5:	5d                   	pop    %ebp
80104eb6:	c3                   	ret    
80104eb7:	89 f6                	mov    %esi,%esi
80104eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ec0 <sys_unlink>:
80104ec0:	55                   	push   %ebp
80104ec1:	89 e5                	mov    %esp,%ebp
80104ec3:	57                   	push   %edi
80104ec4:	56                   	push   %esi
80104ec5:	53                   	push   %ebx
80104ec6:	83 ec 5c             	sub    $0x5c,%esp
80104ec9:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104ecc:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ed0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104ed7:	e8 34 fa ff ff       	call   80104910 <argstr>
80104edc:	85 c0                	test   %eax,%eax
80104ede:	0f 88 76 01 00 00    	js     8010505a <sys_unlink+0x19a>
80104ee4:	e8 27 dc ff ff       	call   80102b10 <begin_op>
80104ee9:	8b 45 c0             	mov    -0x40(%ebp),%eax
80104eec:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80104eef:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104ef3:	89 04 24             	mov    %eax,(%esp)
80104ef6:	e8 25 d0 ff ff       	call   80101f20 <nameiparent>
80104efb:	85 c0                	test   %eax,%eax
80104efd:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104f00:	0f 84 4f 01 00 00    	je     80105055 <sys_unlink+0x195>
80104f06:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104f09:	89 34 24             	mov    %esi,(%esp)
80104f0c:	e8 9f c7 ff ff       	call   801016b0 <ilock>
80104f11:	c7 44 24 04 e0 77 10 	movl   $0x801077e0,0x4(%esp)
80104f18:	80 
80104f19:	89 1c 24             	mov    %ebx,(%esp)
80104f1c:	e8 6f cc ff ff       	call   80101b90 <namecmp>
80104f21:	85 c0                	test   %eax,%eax
80104f23:	0f 84 21 01 00 00    	je     8010504a <sys_unlink+0x18a>
80104f29:	c7 44 24 04 df 77 10 	movl   $0x801077df,0x4(%esp)
80104f30:	80 
80104f31:	89 1c 24             	mov    %ebx,(%esp)
80104f34:	e8 57 cc ff ff       	call   80101b90 <namecmp>
80104f39:	85 c0                	test   %eax,%eax
80104f3b:	0f 84 09 01 00 00    	je     8010504a <sys_unlink+0x18a>
80104f41:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104f44:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104f48:	89 44 24 08          	mov    %eax,0x8(%esp)
80104f4c:	89 34 24             	mov    %esi,(%esp)
80104f4f:	e8 6c cc ff ff       	call   80101bc0 <dirlookup>
80104f54:	85 c0                	test   %eax,%eax
80104f56:	89 c3                	mov    %eax,%ebx
80104f58:	0f 84 ec 00 00 00    	je     8010504a <sys_unlink+0x18a>
80104f5e:	89 04 24             	mov    %eax,(%esp)
80104f61:	e8 4a c7 ff ff       	call   801016b0 <ilock>
80104f66:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80104f6b:	0f 8e 24 01 00 00    	jle    80105095 <sys_unlink+0x1d5>
80104f71:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104f76:	8d 75 d8             	lea    -0x28(%ebp),%esi
80104f79:	74 7d                	je     80104ff8 <sys_unlink+0x138>
80104f7b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104f82:	00 
80104f83:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104f8a:	00 
80104f8b:	89 34 24             	mov    %esi,(%esp)
80104f8e:	e8 fd f5 ff ff       	call   80104590 <memset>
80104f93:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80104f96:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104f9d:	00 
80104f9e:	89 74 24 04          	mov    %esi,0x4(%esp)
80104fa2:	89 44 24 08          	mov    %eax,0x8(%esp)
80104fa6:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104fa9:	89 04 24             	mov    %eax,(%esp)
80104fac:	e8 af ca ff ff       	call   80101a60 <writei>
80104fb1:	83 f8 10             	cmp    $0x10,%eax
80104fb4:	0f 85 cf 00 00 00    	jne    80105089 <sys_unlink+0x1c9>
80104fba:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104fbf:	0f 84 a3 00 00 00    	je     80105068 <sys_unlink+0x1a8>
80104fc5:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80104fc8:	89 04 24             	mov    %eax,(%esp)
80104fcb:	e8 40 c9 ff ff       	call   80101910 <iunlockput>
80104fd0:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80104fd5:	89 1c 24             	mov    %ebx,(%esp)
80104fd8:	e8 13 c6 ff ff       	call   801015f0 <iupdate>
80104fdd:	89 1c 24             	mov    %ebx,(%esp)
80104fe0:	e8 2b c9 ff ff       	call   80101910 <iunlockput>
80104fe5:	e8 96 db ff ff       	call   80102b80 <end_op>
80104fea:	83 c4 5c             	add    $0x5c,%esp
80104fed:	31 c0                	xor    %eax,%eax
80104fef:	5b                   	pop    %ebx
80104ff0:	5e                   	pop    %esi
80104ff1:	5f                   	pop    %edi
80104ff2:	5d                   	pop    %ebp
80104ff3:	c3                   	ret    
80104ff4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ff8:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80104ffc:	0f 86 79 ff ff ff    	jbe    80104f7b <sys_unlink+0xbb>
80105002:	bf 20 00 00 00       	mov    $0x20,%edi
80105007:	eb 15                	jmp    8010501e <sys_unlink+0x15e>
80105009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105010:	8d 57 10             	lea    0x10(%edi),%edx
80105013:	3b 53 58             	cmp    0x58(%ebx),%edx
80105016:	0f 83 5f ff ff ff    	jae    80104f7b <sys_unlink+0xbb>
8010501c:	89 d7                	mov    %edx,%edi
8010501e:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80105025:	00 
80105026:	89 7c 24 08          	mov    %edi,0x8(%esp)
8010502a:	89 74 24 04          	mov    %esi,0x4(%esp)
8010502e:	89 1c 24             	mov    %ebx,(%esp)
80105031:	e8 2a c9 ff ff       	call   80101960 <readi>
80105036:	83 f8 10             	cmp    $0x10,%eax
80105039:	75 42                	jne    8010507d <sys_unlink+0x1bd>
8010503b:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105040:	74 ce                	je     80105010 <sys_unlink+0x150>
80105042:	89 1c 24             	mov    %ebx,(%esp)
80105045:	e8 c6 c8 ff ff       	call   80101910 <iunlockput>
8010504a:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010504d:	89 04 24             	mov    %eax,(%esp)
80105050:	e8 bb c8 ff ff       	call   80101910 <iunlockput>
80105055:	e8 26 db ff ff       	call   80102b80 <end_op>
8010505a:	83 c4 5c             	add    $0x5c,%esp
8010505d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105062:	5b                   	pop    %ebx
80105063:	5e                   	pop    %esi
80105064:	5f                   	pop    %edi
80105065:	5d                   	pop    %ebp
80105066:	c3                   	ret    
80105067:	90                   	nop
80105068:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010506b:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
80105070:	89 04 24             	mov    %eax,(%esp)
80105073:	e8 78 c5 ff ff       	call   801015f0 <iupdate>
80105078:	e9 48 ff ff ff       	jmp    80104fc5 <sys_unlink+0x105>
8010507d:	c7 04 24 04 78 10 80 	movl   $0x80107804,(%esp)
80105084:	e8 d7 b2 ff ff       	call   80100360 <panic>
80105089:	c7 04 24 16 78 10 80 	movl   $0x80107816,(%esp)
80105090:	e8 cb b2 ff ff       	call   80100360 <panic>
80105095:	c7 04 24 f2 77 10 80 	movl   $0x801077f2,(%esp)
8010509c:	e8 bf b2 ff ff       	call   80100360 <panic>
801050a1:	eb 0d                	jmp    801050b0 <sys_open>
801050a3:	90                   	nop
801050a4:	90                   	nop
801050a5:	90                   	nop
801050a6:	90                   	nop
801050a7:	90                   	nop
801050a8:	90                   	nop
801050a9:	90                   	nop
801050aa:	90                   	nop
801050ab:	90                   	nop
801050ac:	90                   	nop
801050ad:	90                   	nop
801050ae:	90                   	nop
801050af:	90                   	nop

801050b0 <sys_open>:
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	57                   	push   %edi
801050b4:	56                   	push   %esi
801050b5:	53                   	push   %ebx
801050b6:	83 ec 2c             	sub    $0x2c,%esp
801050b9:	8d 45 e0             	lea    -0x20(%ebp),%eax
801050bc:	89 44 24 04          	mov    %eax,0x4(%esp)
801050c0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801050c7:	e8 44 f8 ff ff       	call   80104910 <argstr>
801050cc:	85 c0                	test   %eax,%eax
801050ce:	0f 88 d1 00 00 00    	js     801051a5 <sys_open+0xf5>
801050d4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801050d7:	89 44 24 04          	mov    %eax,0x4(%esp)
801050db:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801050e2:	e8 99 f7 ff ff       	call   80104880 <argint>
801050e7:	85 c0                	test   %eax,%eax
801050e9:	0f 88 b6 00 00 00    	js     801051a5 <sys_open+0xf5>
801050ef:	e8 1c da ff ff       	call   80102b10 <begin_op>
801050f4:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801050f8:	0f 85 82 00 00 00    	jne    80105180 <sys_open+0xd0>
801050fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105101:	89 04 24             	mov    %eax,(%esp)
80105104:	e8 f7 cd ff ff       	call   80101f00 <namei>
80105109:	85 c0                	test   %eax,%eax
8010510b:	89 c6                	mov    %eax,%esi
8010510d:	0f 84 8d 00 00 00    	je     801051a0 <sys_open+0xf0>
80105113:	89 04 24             	mov    %eax,(%esp)
80105116:	e8 95 c5 ff ff       	call   801016b0 <ilock>
8010511b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105120:	0f 84 92 00 00 00    	je     801051b8 <sys_open+0x108>
80105126:	e8 45 bc ff ff       	call   80100d70 <filealloc>
8010512b:	85 c0                	test   %eax,%eax
8010512d:	89 c3                	mov    %eax,%ebx
8010512f:	0f 84 93 00 00 00    	je     801051c8 <sys_open+0x118>
80105135:	e8 86 f8 ff ff       	call   801049c0 <fdalloc>
8010513a:	85 c0                	test   %eax,%eax
8010513c:	89 c7                	mov    %eax,%edi
8010513e:	0f 88 94 00 00 00    	js     801051d8 <sys_open+0x128>
80105144:	89 34 24             	mov    %esi,(%esp)
80105147:	e8 44 c6 ff ff       	call   80101790 <iunlock>
8010514c:	e8 2f da ff ff       	call   80102b80 <end_op>
80105151:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
80105157:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010515a:	89 73 10             	mov    %esi,0x10(%ebx)
8010515d:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
80105164:	89 c2                	mov    %eax,%edx
80105166:	83 e2 01             	and    $0x1,%edx
80105169:	83 f2 01             	xor    $0x1,%edx
8010516c:	a8 03                	test   $0x3,%al
8010516e:	88 53 08             	mov    %dl,0x8(%ebx)
80105171:	89 f8                	mov    %edi,%eax
80105173:	0f 95 43 09          	setne  0x9(%ebx)
80105177:	83 c4 2c             	add    $0x2c,%esp
8010517a:	5b                   	pop    %ebx
8010517b:	5e                   	pop    %esi
8010517c:	5f                   	pop    %edi
8010517d:	5d                   	pop    %ebp
8010517e:	c3                   	ret    
8010517f:	90                   	nop
80105180:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105183:	31 c9                	xor    %ecx,%ecx
80105185:	ba 02 00 00 00       	mov    $0x2,%edx
8010518a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105191:	e8 6a f8 ff ff       	call   80104a00 <create>
80105196:	85 c0                	test   %eax,%eax
80105198:	89 c6                	mov    %eax,%esi
8010519a:	75 8a                	jne    80105126 <sys_open+0x76>
8010519c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051a0:	e8 db d9 ff ff       	call   80102b80 <end_op>
801051a5:	83 c4 2c             	add    $0x2c,%esp
801051a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051ad:	5b                   	pop    %ebx
801051ae:	5e                   	pop    %esi
801051af:	5f                   	pop    %edi
801051b0:	5d                   	pop    %ebp
801051b1:	c3                   	ret    
801051b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801051b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801051bb:	85 c0                	test   %eax,%eax
801051bd:	0f 84 63 ff ff ff    	je     80105126 <sys_open+0x76>
801051c3:	90                   	nop
801051c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051c8:	89 34 24             	mov    %esi,(%esp)
801051cb:	e8 40 c7 ff ff       	call   80101910 <iunlockput>
801051d0:	eb ce                	jmp    801051a0 <sys_open+0xf0>
801051d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801051d8:	89 1c 24             	mov    %ebx,(%esp)
801051db:	e8 50 bc ff ff       	call   80100e30 <fileclose>
801051e0:	eb e6                	jmp    801051c8 <sys_open+0x118>
801051e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051f0 <sys_mkdir>:
801051f0:	55                   	push   %ebp
801051f1:	89 e5                	mov    %esp,%ebp
801051f3:	83 ec 28             	sub    $0x28,%esp
801051f6:	e8 15 d9 ff ff       	call   80102b10 <begin_op>
801051fb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801051fe:	89 44 24 04          	mov    %eax,0x4(%esp)
80105202:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105209:	e8 02 f7 ff ff       	call   80104910 <argstr>
8010520e:	85 c0                	test   %eax,%eax
80105210:	78 2e                	js     80105240 <sys_mkdir+0x50>
80105212:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105215:	31 c9                	xor    %ecx,%ecx
80105217:	ba 01 00 00 00       	mov    $0x1,%edx
8010521c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105223:	e8 d8 f7 ff ff       	call   80104a00 <create>
80105228:	85 c0                	test   %eax,%eax
8010522a:	74 14                	je     80105240 <sys_mkdir+0x50>
8010522c:	89 04 24             	mov    %eax,(%esp)
8010522f:	e8 dc c6 ff ff       	call   80101910 <iunlockput>
80105234:	e8 47 d9 ff ff       	call   80102b80 <end_op>
80105239:	31 c0                	xor    %eax,%eax
8010523b:	c9                   	leave  
8010523c:	c3                   	ret    
8010523d:	8d 76 00             	lea    0x0(%esi),%esi
80105240:	e8 3b d9 ff ff       	call   80102b80 <end_op>
80105245:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010524a:	c9                   	leave  
8010524b:	c3                   	ret    
8010524c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105250 <sys_mknod>:
80105250:	55                   	push   %ebp
80105251:	89 e5                	mov    %esp,%ebp
80105253:	83 ec 28             	sub    $0x28,%esp
80105256:	e8 b5 d8 ff ff       	call   80102b10 <begin_op>
8010525b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010525e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105262:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105269:	e8 a2 f6 ff ff       	call   80104910 <argstr>
8010526e:	85 c0                	test   %eax,%eax
80105270:	78 5e                	js     801052d0 <sys_mknod+0x80>
80105272:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105275:	89 44 24 04          	mov    %eax,0x4(%esp)
80105279:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105280:	e8 fb f5 ff ff       	call   80104880 <argint>
80105285:	85 c0                	test   %eax,%eax
80105287:	78 47                	js     801052d0 <sys_mknod+0x80>
80105289:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010528c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105290:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105297:	e8 e4 f5 ff ff       	call   80104880 <argint>
8010529c:	85 c0                	test   %eax,%eax
8010529e:	78 30                	js     801052d0 <sys_mknod+0x80>
801052a0:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801052a4:	ba 03 00 00 00       	mov    $0x3,%edx
801052a9:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801052ad:	89 04 24             	mov    %eax,(%esp)
801052b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801052b3:	e8 48 f7 ff ff       	call   80104a00 <create>
801052b8:	85 c0                	test   %eax,%eax
801052ba:	74 14                	je     801052d0 <sys_mknod+0x80>
801052bc:	89 04 24             	mov    %eax,(%esp)
801052bf:	e8 4c c6 ff ff       	call   80101910 <iunlockput>
801052c4:	e8 b7 d8 ff ff       	call   80102b80 <end_op>
801052c9:	31 c0                	xor    %eax,%eax
801052cb:	c9                   	leave  
801052cc:	c3                   	ret    
801052cd:	8d 76 00             	lea    0x0(%esi),%esi
801052d0:	e8 ab d8 ff ff       	call   80102b80 <end_op>
801052d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052da:	c9                   	leave  
801052db:	c3                   	ret    
801052dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801052e0 <sys_chdir>:
801052e0:	55                   	push   %ebp
801052e1:	89 e5                	mov    %esp,%ebp
801052e3:	56                   	push   %esi
801052e4:	53                   	push   %ebx
801052e5:	83 ec 20             	sub    $0x20,%esp
801052e8:	e8 03 e4 ff ff       	call   801036f0 <myproc>
801052ed:	89 c6                	mov    %eax,%esi
801052ef:	e8 1c d8 ff ff       	call   80102b10 <begin_op>
801052f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052f7:	89 44 24 04          	mov    %eax,0x4(%esp)
801052fb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105302:	e8 09 f6 ff ff       	call   80104910 <argstr>
80105307:	85 c0                	test   %eax,%eax
80105309:	78 4a                	js     80105355 <sys_chdir+0x75>
8010530b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010530e:	89 04 24             	mov    %eax,(%esp)
80105311:	e8 ea cb ff ff       	call   80101f00 <namei>
80105316:	85 c0                	test   %eax,%eax
80105318:	89 c3                	mov    %eax,%ebx
8010531a:	74 39                	je     80105355 <sys_chdir+0x75>
8010531c:	89 04 24             	mov    %eax,(%esp)
8010531f:	e8 8c c3 ff ff       	call   801016b0 <ilock>
80105324:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105329:	89 1c 24             	mov    %ebx,(%esp)
8010532c:	75 22                	jne    80105350 <sys_chdir+0x70>
8010532e:	e8 5d c4 ff ff       	call   80101790 <iunlock>
80105333:	8b 46 68             	mov    0x68(%esi),%eax
80105336:	89 04 24             	mov    %eax,(%esp)
80105339:	e8 92 c4 ff ff       	call   801017d0 <iput>
8010533e:	e8 3d d8 ff ff       	call   80102b80 <end_op>
80105343:	31 c0                	xor    %eax,%eax
80105345:	89 5e 68             	mov    %ebx,0x68(%esi)
80105348:	83 c4 20             	add    $0x20,%esp
8010534b:	5b                   	pop    %ebx
8010534c:	5e                   	pop    %esi
8010534d:	5d                   	pop    %ebp
8010534e:	c3                   	ret    
8010534f:	90                   	nop
80105350:	e8 bb c5 ff ff       	call   80101910 <iunlockput>
80105355:	e8 26 d8 ff ff       	call   80102b80 <end_op>
8010535a:	83 c4 20             	add    $0x20,%esp
8010535d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105362:	5b                   	pop    %ebx
80105363:	5e                   	pop    %esi
80105364:	5d                   	pop    %ebp
80105365:	c3                   	ret    
80105366:	8d 76 00             	lea    0x0(%esi),%esi
80105369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105370 <sys_exec>:
80105370:	55                   	push   %ebp
80105371:	89 e5                	mov    %esp,%ebp
80105373:	57                   	push   %edi
80105374:	56                   	push   %esi
80105375:	53                   	push   %ebx
80105376:	81 ec ac 00 00 00    	sub    $0xac,%esp
8010537c:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80105382:	89 44 24 04          	mov    %eax,0x4(%esp)
80105386:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010538d:	e8 7e f5 ff ff       	call   80104910 <argstr>
80105392:	85 c0                	test   %eax,%eax
80105394:	0f 88 84 00 00 00    	js     8010541e <sys_exec+0xae>
8010539a:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801053a0:	89 44 24 04          	mov    %eax,0x4(%esp)
801053a4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801053ab:	e8 d0 f4 ff ff       	call   80104880 <argint>
801053b0:	85 c0                	test   %eax,%eax
801053b2:	78 6a                	js     8010541e <sys_exec+0xae>
801053b4:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801053ba:	31 db                	xor    %ebx,%ebx
801053bc:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
801053c3:	00 
801053c4:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
801053ca:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801053d1:	00 
801053d2:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801053d8:	89 04 24             	mov    %eax,(%esp)
801053db:	e8 b0 f1 ff ff       	call   80104590 <memset>
801053e0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801053e6:	89 7c 24 04          	mov    %edi,0x4(%esp)
801053ea:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801053ed:	89 04 24             	mov    %eax,(%esp)
801053f0:	e8 eb f3 ff ff       	call   801047e0 <fetchint>
801053f5:	85 c0                	test   %eax,%eax
801053f7:	78 25                	js     8010541e <sys_exec+0xae>
801053f9:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801053ff:	85 c0                	test   %eax,%eax
80105401:	74 2d                	je     80105430 <sys_exec+0xc0>
80105403:	89 74 24 04          	mov    %esi,0x4(%esp)
80105407:	89 04 24             	mov    %eax,(%esp)
8010540a:	e8 11 f4 ff ff       	call   80104820 <fetchstr>
8010540f:	85 c0                	test   %eax,%eax
80105411:	78 0b                	js     8010541e <sys_exec+0xae>
80105413:	83 c3 01             	add    $0x1,%ebx
80105416:	83 c6 04             	add    $0x4,%esi
80105419:	83 fb 20             	cmp    $0x20,%ebx
8010541c:	75 c2                	jne    801053e0 <sys_exec+0x70>
8010541e:	81 c4 ac 00 00 00    	add    $0xac,%esp
80105424:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105429:	5b                   	pop    %ebx
8010542a:	5e                   	pop    %esi
8010542b:	5f                   	pop    %edi
8010542c:	5d                   	pop    %ebp
8010542d:	c3                   	ret    
8010542e:	66 90                	xchg   %ax,%ax
80105430:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105436:	89 44 24 04          	mov    %eax,0x4(%esp)
8010543a:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
80105440:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105447:	00 00 00 00 
8010544b:	89 04 24             	mov    %eax,(%esp)
8010544e:	e8 4d b5 ff ff       	call   801009a0 <exec>
80105453:	81 c4 ac 00 00 00    	add    $0xac,%esp
80105459:	5b                   	pop    %ebx
8010545a:	5e                   	pop    %esi
8010545b:	5f                   	pop    %edi
8010545c:	5d                   	pop    %ebp
8010545d:	c3                   	ret    
8010545e:	66 90                	xchg   %ax,%ax

80105460 <sys_pipe>:
80105460:	55                   	push   %ebp
80105461:	89 e5                	mov    %esp,%ebp
80105463:	53                   	push   %ebx
80105464:	83 ec 24             	sub    $0x24,%esp
80105467:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010546a:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
80105471:	00 
80105472:	89 44 24 04          	mov    %eax,0x4(%esp)
80105476:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010547d:	e8 2e f4 ff ff       	call   801048b0 <argptr>
80105482:	85 c0                	test   %eax,%eax
80105484:	78 6d                	js     801054f3 <sys_pipe+0x93>
80105486:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105489:	89 44 24 04          	mov    %eax,0x4(%esp)
8010548d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105490:	89 04 24             	mov    %eax,(%esp)
80105493:	e8 d8 dc ff ff       	call   80103170 <pipealloc>
80105498:	85 c0                	test   %eax,%eax
8010549a:	78 57                	js     801054f3 <sys_pipe+0x93>
8010549c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010549f:	e8 1c f5 ff ff       	call   801049c0 <fdalloc>
801054a4:	85 c0                	test   %eax,%eax
801054a6:	89 c3                	mov    %eax,%ebx
801054a8:	78 33                	js     801054dd <sys_pipe+0x7d>
801054aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054ad:	e8 0e f5 ff ff       	call   801049c0 <fdalloc>
801054b2:	85 c0                	test   %eax,%eax
801054b4:	78 1a                	js     801054d0 <sys_pipe+0x70>
801054b6:	8b 55 ec             	mov    -0x14(%ebp),%edx
801054b9:	89 1a                	mov    %ebx,(%edx)
801054bb:	8b 55 ec             	mov    -0x14(%ebp),%edx
801054be:	89 42 04             	mov    %eax,0x4(%edx)
801054c1:	83 c4 24             	add    $0x24,%esp
801054c4:	31 c0                	xor    %eax,%eax
801054c6:	5b                   	pop    %ebx
801054c7:	5d                   	pop    %ebp
801054c8:	c3                   	ret    
801054c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054d0:	e8 1b e2 ff ff       	call   801036f0 <myproc>
801054d5:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
801054dc:	00 
801054dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801054e0:	89 04 24             	mov    %eax,(%esp)
801054e3:	e8 48 b9 ff ff       	call   80100e30 <fileclose>
801054e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054eb:	89 04 24             	mov    %eax,(%esp)
801054ee:	e8 3d b9 ff ff       	call   80100e30 <fileclose>
801054f3:	83 c4 24             	add    $0x24,%esp
801054f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054fb:	5b                   	pop    %ebx
801054fc:	5d                   	pop    %ebp
801054fd:	c3                   	ret    
801054fe:	66 90                	xchg   %ax,%ax

80105500 <sys_fork>:
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	5d                   	pop    %ebp
80105504:	e9 97 e3 ff ff       	jmp    801038a0 <fork>
80105509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105510 <sys_exit>:
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	83 ec 28             	sub    $0x28,%esp
80105516:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105519:	89 44 24 04          	mov    %eax,0x4(%esp)
8010551d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105524:	e8 57 f3 ff ff       	call   80104880 <argint>
80105529:	85 c0                	test   %eax,%eax
8010552b:	78 13                	js     80105540 <sys_exit+0x30>
8010552d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105530:	89 04 24             	mov    %eax,(%esp)
80105533:	e8 b8 e6 ff ff       	call   80103bf0 <exit>
80105538:	31 c0                	xor    %eax,%eax
8010553a:	c9                   	leave  
8010553b:	c3                   	ret    
8010553c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105540:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105545:	c9                   	leave  
80105546:	c3                   	ret    
80105547:	89 f6                	mov    %esi,%esi
80105549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105550 <sys_wait>:
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	83 ec 28             	sub    $0x28,%esp
80105556:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105559:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80105560:	00 
80105561:	89 44 24 04          	mov    %eax,0x4(%esp)
80105565:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010556c:	e8 3f f3 ff ff       	call   801048b0 <argptr>
80105571:	85 c0                	test   %eax,%eax
80105573:	78 13                	js     80105588 <sys_wait+0x38>
80105575:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105578:	89 04 24             	mov    %eax,(%esp)
8010557b:	e8 d0 e8 ff ff       	call   80103e50 <wait>
80105580:	c9                   	leave  
80105581:	c3                   	ret    
80105582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105588:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010558d:	c9                   	leave  
8010558e:	c3                   	ret    
8010558f:	90                   	nop

80105590 <sys_waitpid>:
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	83 ec 28             	sub    $0x28,%esp
80105596:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105599:	89 44 24 04          	mov    %eax,0x4(%esp)
8010559d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801055a4:	e8 d7 f2 ff ff       	call   80104880 <argint>
801055a9:	85 c0                	test   %eax,%eax
801055ab:	78 53                	js     80105600 <sys_waitpid+0x70>
801055ad:	8d 45 f0             	lea    -0x10(%ebp),%eax
801055b0:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
801055b7:	00 
801055b8:	89 44 24 04          	mov    %eax,0x4(%esp)
801055bc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801055c3:	e8 e8 f2 ff ff       	call   801048b0 <argptr>
801055c8:	85 c0                	test   %eax,%eax
801055ca:	78 34                	js     80105600 <sys_waitpid+0x70>
801055cc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055cf:	89 44 24 04          	mov    %eax,0x4(%esp)
801055d3:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801055da:	e8 a1 f2 ff ff       	call   80104880 <argint>
801055df:	85 c0                	test   %eax,%eax
801055e1:	78 1d                	js     80105600 <sys_waitpid+0x70>
801055e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055e6:	89 44 24 08          	mov    %eax,0x8(%esp)
801055ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
801055ed:	89 44 24 04          	mov    %eax,0x4(%esp)
801055f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801055f4:	89 04 24             	mov    %eax,(%esp)
801055f7:	e8 44 e9 ff ff       	call   80103f40 <waitpid>
801055fc:	c9                   	leave  
801055fd:	c3                   	ret    
801055fe:	66 90                	xchg   %ax,%ax
80105600:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105605:	c9                   	leave  
80105606:	c3                   	ret    
80105607:	89 f6                	mov    %esi,%esi
80105609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105610 <sys_set_prior>:
80105610:	55                   	push   %ebp
80105611:	89 e5                	mov    %esp,%ebp
80105613:	83 ec 28             	sub    $0x28,%esp
80105616:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105619:	89 44 24 04          	mov    %eax,0x4(%esp)
8010561d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105624:	e8 57 f2 ff ff       	call   80104880 <argint>
80105629:	85 c0                	test   %eax,%eax
8010562b:	78 13                	js     80105640 <sys_set_prior+0x30>
8010562d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105630:	89 04 24             	mov    %eax,(%esp)
80105633:	e8 b8 e4 ff ff       	call   80103af0 <set_prior>
80105638:	c9                   	leave  
80105639:	c3                   	ret    
8010563a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105640:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105645:	c9                   	leave  
80105646:	c3                   	ret    
80105647:	89 f6                	mov    %esi,%esi
80105649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105650 <sys_kill>:
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	83 ec 28             	sub    $0x28,%esp
80105656:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105659:	89 44 24 04          	mov    %eax,0x4(%esp)
8010565d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105664:	e8 17 f2 ff ff       	call   80104880 <argint>
80105669:	85 c0                	test   %eax,%eax
8010566b:	78 13                	js     80105680 <sys_kill+0x30>
8010566d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105670:	89 04 24             	mov    %eax,(%esp)
80105673:	e8 48 ea ff ff       	call   801040c0 <kill>
80105678:	c9                   	leave  
80105679:	c3                   	ret    
8010567a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105680:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105685:	c9                   	leave  
80105686:	c3                   	ret    
80105687:	89 f6                	mov    %esi,%esi
80105689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105690 <sys_getpid>:
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
80105693:	83 ec 08             	sub    $0x8,%esp
80105696:	e8 55 e0 ff ff       	call   801036f0 <myproc>
8010569b:	8b 40 10             	mov    0x10(%eax),%eax
8010569e:	c9                   	leave  
8010569f:	c3                   	ret    

801056a0 <sys_sbrk>:
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	53                   	push   %ebx
801056a4:	83 ec 24             	sub    $0x24,%esp
801056a7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056aa:	89 44 24 04          	mov    %eax,0x4(%esp)
801056ae:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801056b5:	e8 c6 f1 ff ff       	call   80104880 <argint>
801056ba:	85 c0                	test   %eax,%eax
801056bc:	78 22                	js     801056e0 <sys_sbrk+0x40>
801056be:	e8 2d e0 ff ff       	call   801036f0 <myproc>
801056c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801056c6:	8b 18                	mov    (%eax),%ebx
801056c8:	89 14 24             	mov    %edx,(%esp)
801056cb:	e8 60 e1 ff ff       	call   80103830 <growproc>
801056d0:	85 c0                	test   %eax,%eax
801056d2:	78 0c                	js     801056e0 <sys_sbrk+0x40>
801056d4:	89 d8                	mov    %ebx,%eax
801056d6:	83 c4 24             	add    $0x24,%esp
801056d9:	5b                   	pop    %ebx
801056da:	5d                   	pop    %ebp
801056db:	c3                   	ret    
801056dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056e5:	eb ef                	jmp    801056d6 <sys_sbrk+0x36>
801056e7:	89 f6                	mov    %esi,%esi
801056e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056f0 <sys_sleep>:
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
801056f3:	53                   	push   %ebx
801056f4:	83 ec 24             	sub    $0x24,%esp
801056f7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056fa:	89 44 24 04          	mov    %eax,0x4(%esp)
801056fe:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105705:	e8 76 f1 ff ff       	call   80104880 <argint>
8010570a:	85 c0                	test   %eax,%eax
8010570c:	78 7e                	js     8010578c <sys_sleep+0x9c>
8010570e:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
80105715:	e8 b6 ed ff ff       	call   801044d0 <acquire>
8010571a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010571d:	8b 1d a0 58 11 80    	mov    0x801158a0,%ebx
80105723:	85 d2                	test   %edx,%edx
80105725:	75 29                	jne    80105750 <sys_sleep+0x60>
80105727:	eb 4f                	jmp    80105778 <sys_sleep+0x88>
80105729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105730:	c7 44 24 04 60 50 11 	movl   $0x80115060,0x4(%esp)
80105737:	80 
80105738:	c7 04 24 a0 58 11 80 	movl   $0x801158a0,(%esp)
8010573f:	e8 5c e6 ff ff       	call   80103da0 <sleep>
80105744:	a1 a0 58 11 80       	mov    0x801158a0,%eax
80105749:	29 d8                	sub    %ebx,%eax
8010574b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010574e:	73 28                	jae    80105778 <sys_sleep+0x88>
80105750:	e8 9b df ff ff       	call   801036f0 <myproc>
80105755:	8b 40 24             	mov    0x24(%eax),%eax
80105758:	85 c0                	test   %eax,%eax
8010575a:	74 d4                	je     80105730 <sys_sleep+0x40>
8010575c:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
80105763:	e8 d8 ed ff ff       	call   80104540 <release>
80105768:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010576d:	83 c4 24             	add    $0x24,%esp
80105770:	5b                   	pop    %ebx
80105771:	5d                   	pop    %ebp
80105772:	c3                   	ret    
80105773:	90                   	nop
80105774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105778:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
8010577f:	e8 bc ed ff ff       	call   80104540 <release>
80105784:	83 c4 24             	add    $0x24,%esp
80105787:	31 c0                	xor    %eax,%eax
80105789:	5b                   	pop    %ebx
8010578a:	5d                   	pop    %ebp
8010578b:	c3                   	ret    
8010578c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105791:	eb da                	jmp    8010576d <sys_sleep+0x7d>
80105793:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057a0 <sys_hello>:
801057a0:	55                   	push   %ebp
801057a1:	89 e5                	mov    %esp,%ebp
801057a3:	83 ec 08             	sub    $0x8,%esp
801057a6:	e8 65 ea ff ff       	call   80104210 <hello>
801057ab:	31 c0                	xor    %eax,%eax
801057ad:	c9                   	leave  
801057ae:	c3                   	ret    
801057af:	90                   	nop

801057b0 <sys_uptime>:
801057b0:	55                   	push   %ebp
801057b1:	89 e5                	mov    %esp,%ebp
801057b3:	53                   	push   %ebx
801057b4:	83 ec 14             	sub    $0x14,%esp
801057b7:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
801057be:	e8 0d ed ff ff       	call   801044d0 <acquire>
801057c3:	8b 1d a0 58 11 80    	mov    0x801158a0,%ebx
801057c9:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
801057d0:	e8 6b ed ff ff       	call   80104540 <release>
801057d5:	83 c4 14             	add    $0x14,%esp
801057d8:	89 d8                	mov    %ebx,%eax
801057da:	5b                   	pop    %ebx
801057db:	5d                   	pop    %ebp
801057dc:	c3                   	ret    

801057dd <alltraps>:
801057dd:	1e                   	push   %ds
801057de:	06                   	push   %es
801057df:	0f a0                	push   %fs
801057e1:	0f a8                	push   %gs
801057e3:	60                   	pusha  
801057e4:	66 b8 10 00          	mov    $0x10,%ax
801057e8:	8e d8                	mov    %eax,%ds
801057ea:	8e c0                	mov    %eax,%es
801057ec:	54                   	push   %esp
801057ed:	e8 de 00 00 00       	call   801058d0 <trap>
801057f2:	83 c4 04             	add    $0x4,%esp

801057f5 <trapret>:
801057f5:	61                   	popa   
801057f6:	0f a9                	pop    %gs
801057f8:	0f a1                	pop    %fs
801057fa:	07                   	pop    %es
801057fb:	1f                   	pop    %ds
801057fc:	83 c4 08             	add    $0x8,%esp
801057ff:	cf                   	iret   

80105800 <tvinit>:
80105800:	31 c0                	xor    %eax,%eax
80105802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105808:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
8010580f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105814:	66 89 0c c5 a2 50 11 	mov    %cx,-0x7feeaf5e(,%eax,8)
8010581b:	80 
8010581c:	c6 04 c5 a4 50 11 80 	movb   $0x0,-0x7feeaf5c(,%eax,8)
80105823:	00 
80105824:	c6 04 c5 a5 50 11 80 	movb   $0x8e,-0x7feeaf5b(,%eax,8)
8010582b:	8e 
8010582c:	66 89 14 c5 a0 50 11 	mov    %dx,-0x7feeaf60(,%eax,8)
80105833:	80 
80105834:	c1 ea 10             	shr    $0x10,%edx
80105837:	66 89 14 c5 a6 50 11 	mov    %dx,-0x7feeaf5a(,%eax,8)
8010583e:	80 
8010583f:	83 c0 01             	add    $0x1,%eax
80105842:	3d 00 01 00 00       	cmp    $0x100,%eax
80105847:	75 bf                	jne    80105808 <tvinit+0x8>
80105849:	55                   	push   %ebp
8010584a:	ba 08 00 00 00       	mov    $0x8,%edx
8010584f:	89 e5                	mov    %esp,%ebp
80105851:	83 ec 18             	sub    $0x18,%esp
80105854:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105859:	c7 44 24 04 25 78 10 	movl   $0x80107825,0x4(%esp)
80105860:	80 
80105861:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
80105868:	66 89 15 a2 52 11 80 	mov    %dx,0x801152a2
8010586f:	66 a3 a0 52 11 80    	mov    %ax,0x801152a0
80105875:	c1 e8 10             	shr    $0x10,%eax
80105878:	c6 05 a4 52 11 80 00 	movb   $0x0,0x801152a4
8010587f:	c6 05 a5 52 11 80 ef 	movb   $0xef,0x801152a5
80105886:	66 a3 a6 52 11 80    	mov    %ax,0x801152a6
8010588c:	e8 cf ea ff ff       	call   80104360 <initlock>
80105891:	c9                   	leave  
80105892:	c3                   	ret    
80105893:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105899:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058a0 <idtinit>:
801058a0:	55                   	push   %ebp
801058a1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801058a6:	89 e5                	mov    %esp,%ebp
801058a8:	83 ec 10             	sub    $0x10,%esp
801058ab:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
801058af:	b8 a0 50 11 80       	mov    $0x801150a0,%eax
801058b4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801058b8:	c1 e8 10             	shr    $0x10,%eax
801058bb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
801058bf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801058c2:	0f 01 18             	lidtl  (%eax)
801058c5:	c9                   	leave  
801058c6:	c3                   	ret    
801058c7:	89 f6                	mov    %esi,%esi
801058c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058d0 <trap>:
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	57                   	push   %edi
801058d4:	56                   	push   %esi
801058d5:	53                   	push   %ebx
801058d6:	83 ec 3c             	sub    $0x3c,%esp
801058d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801058dc:	8b 43 30             	mov    0x30(%ebx),%eax
801058df:	83 f8 40             	cmp    $0x40,%eax
801058e2:	0f 84 a0 01 00 00    	je     80105a88 <trap+0x1b8>
801058e8:	83 e8 20             	sub    $0x20,%eax
801058eb:	83 f8 1f             	cmp    $0x1f,%eax
801058ee:	77 08                	ja     801058f8 <trap+0x28>
801058f0:	ff 24 85 cc 78 10 80 	jmp    *-0x7fef8734(,%eax,4)
801058f7:	90                   	nop
801058f8:	e8 f3 dd ff ff       	call   801036f0 <myproc>
801058fd:	85 c0                	test   %eax,%eax
801058ff:	90                   	nop
80105900:	0f 84 0a 02 00 00    	je     80105b10 <trap+0x240>
80105906:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
8010590a:	0f 84 00 02 00 00    	je     80105b10 <trap+0x240>
80105910:	0f 20 d1             	mov    %cr2,%ecx
80105913:	8b 53 38             	mov    0x38(%ebx),%edx
80105916:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105919:	89 55 dc             	mov    %edx,-0x24(%ebp)
8010591c:	e8 af dd ff ff       	call   801036d0 <cpuid>
80105921:	8b 73 30             	mov    0x30(%ebx),%esi
80105924:	89 c7                	mov    %eax,%edi
80105926:	8b 43 34             	mov    0x34(%ebx),%eax
80105929:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010592c:	e8 bf dd ff ff       	call   801036f0 <myproc>
80105931:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105934:	e8 b7 dd ff ff       	call   801036f0 <myproc>
80105939:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010593c:	89 74 24 0c          	mov    %esi,0xc(%esp)
80105940:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105943:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105946:	89 7c 24 14          	mov    %edi,0x14(%esp)
8010594a:	89 54 24 18          	mov    %edx,0x18(%esp)
8010594e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105951:	83 c6 6c             	add    $0x6c,%esi
80105954:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
80105958:	89 74 24 08          	mov    %esi,0x8(%esp)
8010595c:	89 54 24 10          	mov    %edx,0x10(%esp)
80105960:	8b 40 10             	mov    0x10(%eax),%eax
80105963:	c7 04 24 88 78 10 80 	movl   $0x80107888,(%esp)
8010596a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010596e:	e8 dd ac ff ff       	call   80100650 <cprintf>
80105973:	e8 78 dd ff ff       	call   801036f0 <myproc>
80105978:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
8010597f:	90                   	nop
80105980:	e8 6b dd ff ff       	call   801036f0 <myproc>
80105985:	85 c0                	test   %eax,%eax
80105987:	74 0c                	je     80105995 <trap+0xc5>
80105989:	e8 62 dd ff ff       	call   801036f0 <myproc>
8010598e:	8b 50 24             	mov    0x24(%eax),%edx
80105991:	85 d2                	test   %edx,%edx
80105993:	75 4b                	jne    801059e0 <trap+0x110>
80105995:	e8 56 dd ff ff       	call   801036f0 <myproc>
8010599a:	85 c0                	test   %eax,%eax
8010599c:	74 0d                	je     801059ab <trap+0xdb>
8010599e:	66 90                	xchg   %ax,%ax
801059a0:	e8 4b dd ff ff       	call   801036f0 <myproc>
801059a5:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801059a9:	74 55                	je     80105a00 <trap+0x130>
801059ab:	e8 40 dd ff ff       	call   801036f0 <myproc>
801059b0:	85 c0                	test   %eax,%eax
801059b2:	74 1d                	je     801059d1 <trap+0x101>
801059b4:	e8 37 dd ff ff       	call   801036f0 <myproc>
801059b9:	8b 40 24             	mov    0x24(%eax),%eax
801059bc:	85 c0                	test   %eax,%eax
801059be:	74 11                	je     801059d1 <trap+0x101>
801059c0:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801059c4:	83 e0 03             	and    $0x3,%eax
801059c7:	66 83 f8 03          	cmp    $0x3,%ax
801059cb:	0f 84 e8 00 00 00    	je     80105ab9 <trap+0x1e9>
801059d1:	83 c4 3c             	add    $0x3c,%esp
801059d4:	5b                   	pop    %ebx
801059d5:	5e                   	pop    %esi
801059d6:	5f                   	pop    %edi
801059d7:	5d                   	pop    %ebp
801059d8:	c3                   	ret    
801059d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059e0:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801059e4:	83 e0 03             	and    $0x3,%eax
801059e7:	66 83 f8 03          	cmp    $0x3,%ax
801059eb:	75 a8                	jne    80105995 <trap+0xc5>
801059ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801059f4:	e8 f7 e1 ff ff       	call   80103bf0 <exit>
801059f9:	eb 9a                	jmp    80105995 <trap+0xc5>
801059fb:	90                   	nop
801059fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a00:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105a04:	75 a5                	jne    801059ab <trap+0xdb>
80105a06:	e8 55 e3 ff ff       	call   80103d60 <yield>
80105a0b:	eb 9e                	jmp    801059ab <trap+0xdb>
80105a0d:	8d 76 00             	lea    0x0(%esi),%esi
80105a10:	e8 bb dc ff ff       	call   801036d0 <cpuid>
80105a15:	85 c0                	test   %eax,%eax
80105a17:	0f 84 c3 00 00 00    	je     80105ae0 <trap+0x210>
80105a1d:	8d 76 00             	lea    0x0(%esi),%esi
80105a20:	e8 5b cd ff ff       	call   80102780 <lapiceoi>
80105a25:	e9 56 ff ff ff       	jmp    80105980 <trap+0xb0>
80105a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105a30:	e8 9b cb ff ff       	call   801025d0 <kbdintr>
80105a35:	e8 46 cd ff ff       	call   80102780 <lapiceoi>
80105a3a:	e9 41 ff ff ff       	jmp    80105980 <trap+0xb0>
80105a3f:	90                   	nop
80105a40:	e8 2b 02 00 00       	call   80105c70 <uartintr>
80105a45:	e8 36 cd ff ff       	call   80102780 <lapiceoi>
80105a4a:	e9 31 ff ff ff       	jmp    80105980 <trap+0xb0>
80105a4f:	90                   	nop
80105a50:	8b 7b 38             	mov    0x38(%ebx),%edi
80105a53:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105a57:	e8 74 dc ff ff       	call   801036d0 <cpuid>
80105a5c:	c7 04 24 30 78 10 80 	movl   $0x80107830,(%esp)
80105a63:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80105a67:	89 74 24 08          	mov    %esi,0x8(%esp)
80105a6b:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a6f:	e8 dc ab ff ff       	call   80100650 <cprintf>
80105a74:	e8 07 cd ff ff       	call   80102780 <lapiceoi>
80105a79:	e9 02 ff ff ff       	jmp    80105980 <trap+0xb0>
80105a7e:	66 90                	xchg   %ax,%ax
80105a80:	e8 fb c5 ff ff       	call   80102080 <ideintr>
80105a85:	eb 96                	jmp    80105a1d <trap+0x14d>
80105a87:	90                   	nop
80105a88:	90                   	nop
80105a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a90:	e8 5b dc ff ff       	call   801036f0 <myproc>
80105a95:	8b 70 24             	mov    0x24(%eax),%esi
80105a98:	85 f6                	test   %esi,%esi
80105a9a:	75 34                	jne    80105ad0 <trap+0x200>
80105a9c:	e8 4f dc ff ff       	call   801036f0 <myproc>
80105aa1:	89 58 18             	mov    %ebx,0x18(%eax)
80105aa4:	e8 a7 ee ff ff       	call   80104950 <syscall>
80105aa9:	e8 42 dc ff ff       	call   801036f0 <myproc>
80105aae:	8b 48 24             	mov    0x24(%eax),%ecx
80105ab1:	85 c9                	test   %ecx,%ecx
80105ab3:	0f 84 18 ff ff ff    	je     801059d1 <trap+0x101>
80105ab9:	c7 45 08 00 00 00 00 	movl   $0x0,0x8(%ebp)
80105ac0:	83 c4 3c             	add    $0x3c,%esp
80105ac3:	5b                   	pop    %ebx
80105ac4:	5e                   	pop    %esi
80105ac5:	5f                   	pop    %edi
80105ac6:	5d                   	pop    %ebp
80105ac7:	e9 24 e1 ff ff       	jmp    80103bf0 <exit>
80105acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ad0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105ad7:	e8 14 e1 ff ff       	call   80103bf0 <exit>
80105adc:	eb be                	jmp    80105a9c <trap+0x1cc>
80105ade:	66 90                	xchg   %ax,%ax
80105ae0:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
80105ae7:	e8 e4 e9 ff ff       	call   801044d0 <acquire>
80105aec:	c7 04 24 a0 58 11 80 	movl   $0x801158a0,(%esp)
80105af3:	83 05 a0 58 11 80 01 	addl   $0x1,0x801158a0
80105afa:	e8 51 e5 ff ff       	call   80104050 <wakeup>
80105aff:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
80105b06:	e8 35 ea ff ff       	call   80104540 <release>
80105b0b:	e9 0d ff ff ff       	jmp    80105a1d <trap+0x14d>
80105b10:	0f 20 d7             	mov    %cr2,%edi
80105b13:	8b 73 38             	mov    0x38(%ebx),%esi
80105b16:	e8 b5 db ff ff       	call   801036d0 <cpuid>
80105b1b:	89 7c 24 10          	mov    %edi,0x10(%esp)
80105b1f:	89 74 24 0c          	mov    %esi,0xc(%esp)
80105b23:	89 44 24 08          	mov    %eax,0x8(%esp)
80105b27:	8b 43 30             	mov    0x30(%ebx),%eax
80105b2a:	c7 04 24 54 78 10 80 	movl   $0x80107854,(%esp)
80105b31:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b35:	e8 16 ab ff ff       	call   80100650 <cprintf>
80105b3a:	c7 04 24 2a 78 10 80 	movl   $0x8010782a,(%esp)
80105b41:	e8 1a a8 ff ff       	call   80100360 <panic>
80105b46:	66 90                	xchg   %ax,%ax
80105b48:	66 90                	xchg   %ax,%ax
80105b4a:	66 90                	xchg   %ax,%ax
80105b4c:	66 90                	xchg   %ax,%ax
80105b4e:	66 90                	xchg   %ax,%ax

80105b50 <uartgetc>:
80105b50:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
80105b55:	55                   	push   %ebp
80105b56:	89 e5                	mov    %esp,%ebp
80105b58:	85 c0                	test   %eax,%eax
80105b5a:	74 14                	je     80105b70 <uartgetc+0x20>
80105b5c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105b61:	ec                   	in     (%dx),%al
80105b62:	a8 01                	test   $0x1,%al
80105b64:	74 0a                	je     80105b70 <uartgetc+0x20>
80105b66:	b2 f8                	mov    $0xf8,%dl
80105b68:	ec                   	in     (%dx),%al
80105b69:	0f b6 c0             	movzbl %al,%eax
80105b6c:	5d                   	pop    %ebp
80105b6d:	c3                   	ret    
80105b6e:	66 90                	xchg   %ax,%ax
80105b70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b75:	5d                   	pop    %ebp
80105b76:	c3                   	ret    
80105b77:	89 f6                	mov    %esi,%esi
80105b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b80 <uartputc>:
80105b80:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
80105b85:	85 c0                	test   %eax,%eax
80105b87:	74 3f                	je     80105bc8 <uartputc+0x48>
80105b89:	55                   	push   %ebp
80105b8a:	89 e5                	mov    %esp,%ebp
80105b8c:	56                   	push   %esi
80105b8d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105b92:	53                   	push   %ebx
80105b93:	bb 80 00 00 00       	mov    $0x80,%ebx
80105b98:	83 ec 10             	sub    $0x10,%esp
80105b9b:	eb 14                	jmp    80105bb1 <uartputc+0x31>
80105b9d:	8d 76 00             	lea    0x0(%esi),%esi
80105ba0:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80105ba7:	e8 f4 cb ff ff       	call   801027a0 <microdelay>
80105bac:	83 eb 01             	sub    $0x1,%ebx
80105baf:	74 07                	je     80105bb8 <uartputc+0x38>
80105bb1:	89 f2                	mov    %esi,%edx
80105bb3:	ec                   	in     (%dx),%al
80105bb4:	a8 20                	test   $0x20,%al
80105bb6:	74 e8                	je     80105ba0 <uartputc+0x20>
80105bb8:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
80105bbc:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105bc1:	ee                   	out    %al,(%dx)
80105bc2:	83 c4 10             	add    $0x10,%esp
80105bc5:	5b                   	pop    %ebx
80105bc6:	5e                   	pop    %esi
80105bc7:	5d                   	pop    %ebp
80105bc8:	f3 c3                	repz ret 
80105bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105bd0 <uartinit>:
80105bd0:	55                   	push   %ebp
80105bd1:	31 c9                	xor    %ecx,%ecx
80105bd3:	89 e5                	mov    %esp,%ebp
80105bd5:	89 c8                	mov    %ecx,%eax
80105bd7:	57                   	push   %edi
80105bd8:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105bdd:	56                   	push   %esi
80105bde:	89 fa                	mov    %edi,%edx
80105be0:	53                   	push   %ebx
80105be1:	83 ec 1c             	sub    $0x1c,%esp
80105be4:	ee                   	out    %al,(%dx)
80105be5:	be fb 03 00 00       	mov    $0x3fb,%esi
80105bea:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105bef:	89 f2                	mov    %esi,%edx
80105bf1:	ee                   	out    %al,(%dx)
80105bf2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105bf7:	b2 f8                	mov    $0xf8,%dl
80105bf9:	ee                   	out    %al,(%dx)
80105bfa:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80105bff:	89 c8                	mov    %ecx,%eax
80105c01:	89 da                	mov    %ebx,%edx
80105c03:	ee                   	out    %al,(%dx)
80105c04:	b8 03 00 00 00       	mov    $0x3,%eax
80105c09:	89 f2                	mov    %esi,%edx
80105c0b:	ee                   	out    %al,(%dx)
80105c0c:	b2 fc                	mov    $0xfc,%dl
80105c0e:	89 c8                	mov    %ecx,%eax
80105c10:	ee                   	out    %al,(%dx)
80105c11:	b8 01 00 00 00       	mov    $0x1,%eax
80105c16:	89 da                	mov    %ebx,%edx
80105c18:	ee                   	out    %al,(%dx)
80105c19:	b2 fd                	mov    $0xfd,%dl
80105c1b:	ec                   	in     (%dx),%al
80105c1c:	3c ff                	cmp    $0xff,%al
80105c1e:	74 42                	je     80105c62 <uartinit+0x92>
80105c20:	c7 05 bc a5 10 80 01 	movl   $0x1,0x8010a5bc
80105c27:	00 00 00 
80105c2a:	89 fa                	mov    %edi,%edx
80105c2c:	ec                   	in     (%dx),%al
80105c2d:	b2 f8                	mov    $0xf8,%dl
80105c2f:	ec                   	in     (%dx),%al
80105c30:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105c37:	00 
80105c38:	bb 4c 79 10 80       	mov    $0x8010794c,%ebx
80105c3d:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80105c44:	e8 67 c6 ff ff       	call   801022b0 <ioapicenable>
80105c49:	b8 78 00 00 00       	mov    $0x78,%eax
80105c4e:	66 90                	xchg   %ax,%ax
80105c50:	89 04 24             	mov    %eax,(%esp)
80105c53:	83 c3 01             	add    $0x1,%ebx
80105c56:	e8 25 ff ff ff       	call   80105b80 <uartputc>
80105c5b:	0f be 03             	movsbl (%ebx),%eax
80105c5e:	84 c0                	test   %al,%al
80105c60:	75 ee                	jne    80105c50 <uartinit+0x80>
80105c62:	83 c4 1c             	add    $0x1c,%esp
80105c65:	5b                   	pop    %ebx
80105c66:	5e                   	pop    %esi
80105c67:	5f                   	pop    %edi
80105c68:	5d                   	pop    %ebp
80105c69:	c3                   	ret    
80105c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105c70 <uartintr>:
80105c70:	55                   	push   %ebp
80105c71:	89 e5                	mov    %esp,%ebp
80105c73:	83 ec 18             	sub    $0x18,%esp
80105c76:	c7 04 24 50 5b 10 80 	movl   $0x80105b50,(%esp)
80105c7d:	e8 2e ab ff ff       	call   801007b0 <consoleintr>
80105c82:	c9                   	leave  
80105c83:	c3                   	ret    

80105c84 <vector0>:
80105c84:	6a 00                	push   $0x0
80105c86:	6a 00                	push   $0x0
80105c88:	e9 50 fb ff ff       	jmp    801057dd <alltraps>

80105c8d <vector1>:
80105c8d:	6a 00                	push   $0x0
80105c8f:	6a 01                	push   $0x1
80105c91:	e9 47 fb ff ff       	jmp    801057dd <alltraps>

80105c96 <vector2>:
80105c96:	6a 00                	push   $0x0
80105c98:	6a 02                	push   $0x2
80105c9a:	e9 3e fb ff ff       	jmp    801057dd <alltraps>

80105c9f <vector3>:
80105c9f:	6a 00                	push   $0x0
80105ca1:	6a 03                	push   $0x3
80105ca3:	e9 35 fb ff ff       	jmp    801057dd <alltraps>

80105ca8 <vector4>:
80105ca8:	6a 00                	push   $0x0
80105caa:	6a 04                	push   $0x4
80105cac:	e9 2c fb ff ff       	jmp    801057dd <alltraps>

80105cb1 <vector5>:
80105cb1:	6a 00                	push   $0x0
80105cb3:	6a 05                	push   $0x5
80105cb5:	e9 23 fb ff ff       	jmp    801057dd <alltraps>

80105cba <vector6>:
80105cba:	6a 00                	push   $0x0
80105cbc:	6a 06                	push   $0x6
80105cbe:	e9 1a fb ff ff       	jmp    801057dd <alltraps>

80105cc3 <vector7>:
80105cc3:	6a 00                	push   $0x0
80105cc5:	6a 07                	push   $0x7
80105cc7:	e9 11 fb ff ff       	jmp    801057dd <alltraps>

80105ccc <vector8>:
80105ccc:	6a 08                	push   $0x8
80105cce:	e9 0a fb ff ff       	jmp    801057dd <alltraps>

80105cd3 <vector9>:
80105cd3:	6a 00                	push   $0x0
80105cd5:	6a 09                	push   $0x9
80105cd7:	e9 01 fb ff ff       	jmp    801057dd <alltraps>

80105cdc <vector10>:
80105cdc:	6a 0a                	push   $0xa
80105cde:	e9 fa fa ff ff       	jmp    801057dd <alltraps>

80105ce3 <vector11>:
80105ce3:	6a 0b                	push   $0xb
80105ce5:	e9 f3 fa ff ff       	jmp    801057dd <alltraps>

80105cea <vector12>:
80105cea:	6a 0c                	push   $0xc
80105cec:	e9 ec fa ff ff       	jmp    801057dd <alltraps>

80105cf1 <vector13>:
80105cf1:	6a 0d                	push   $0xd
80105cf3:	e9 e5 fa ff ff       	jmp    801057dd <alltraps>

80105cf8 <vector14>:
80105cf8:	6a 0e                	push   $0xe
80105cfa:	e9 de fa ff ff       	jmp    801057dd <alltraps>

80105cff <vector15>:
80105cff:	6a 00                	push   $0x0
80105d01:	6a 0f                	push   $0xf
80105d03:	e9 d5 fa ff ff       	jmp    801057dd <alltraps>

80105d08 <vector16>:
80105d08:	6a 00                	push   $0x0
80105d0a:	6a 10                	push   $0x10
80105d0c:	e9 cc fa ff ff       	jmp    801057dd <alltraps>

80105d11 <vector17>:
80105d11:	6a 11                	push   $0x11
80105d13:	e9 c5 fa ff ff       	jmp    801057dd <alltraps>

80105d18 <vector18>:
80105d18:	6a 00                	push   $0x0
80105d1a:	6a 12                	push   $0x12
80105d1c:	e9 bc fa ff ff       	jmp    801057dd <alltraps>

80105d21 <vector19>:
80105d21:	6a 00                	push   $0x0
80105d23:	6a 13                	push   $0x13
80105d25:	e9 b3 fa ff ff       	jmp    801057dd <alltraps>

80105d2a <vector20>:
80105d2a:	6a 00                	push   $0x0
80105d2c:	6a 14                	push   $0x14
80105d2e:	e9 aa fa ff ff       	jmp    801057dd <alltraps>

80105d33 <vector21>:
80105d33:	6a 00                	push   $0x0
80105d35:	6a 15                	push   $0x15
80105d37:	e9 a1 fa ff ff       	jmp    801057dd <alltraps>

80105d3c <vector22>:
80105d3c:	6a 00                	push   $0x0
80105d3e:	6a 16                	push   $0x16
80105d40:	e9 98 fa ff ff       	jmp    801057dd <alltraps>

80105d45 <vector23>:
80105d45:	6a 00                	push   $0x0
80105d47:	6a 17                	push   $0x17
80105d49:	e9 8f fa ff ff       	jmp    801057dd <alltraps>

80105d4e <vector24>:
80105d4e:	6a 00                	push   $0x0
80105d50:	6a 18                	push   $0x18
80105d52:	e9 86 fa ff ff       	jmp    801057dd <alltraps>

80105d57 <vector25>:
80105d57:	6a 00                	push   $0x0
80105d59:	6a 19                	push   $0x19
80105d5b:	e9 7d fa ff ff       	jmp    801057dd <alltraps>

80105d60 <vector26>:
80105d60:	6a 00                	push   $0x0
80105d62:	6a 1a                	push   $0x1a
80105d64:	e9 74 fa ff ff       	jmp    801057dd <alltraps>

80105d69 <vector27>:
80105d69:	6a 00                	push   $0x0
80105d6b:	6a 1b                	push   $0x1b
80105d6d:	e9 6b fa ff ff       	jmp    801057dd <alltraps>

80105d72 <vector28>:
80105d72:	6a 00                	push   $0x0
80105d74:	6a 1c                	push   $0x1c
80105d76:	e9 62 fa ff ff       	jmp    801057dd <alltraps>

80105d7b <vector29>:
80105d7b:	6a 00                	push   $0x0
80105d7d:	6a 1d                	push   $0x1d
80105d7f:	e9 59 fa ff ff       	jmp    801057dd <alltraps>

80105d84 <vector30>:
80105d84:	6a 00                	push   $0x0
80105d86:	6a 1e                	push   $0x1e
80105d88:	e9 50 fa ff ff       	jmp    801057dd <alltraps>

80105d8d <vector31>:
80105d8d:	6a 00                	push   $0x0
80105d8f:	6a 1f                	push   $0x1f
80105d91:	e9 47 fa ff ff       	jmp    801057dd <alltraps>

80105d96 <vector32>:
80105d96:	6a 00                	push   $0x0
80105d98:	6a 20                	push   $0x20
80105d9a:	e9 3e fa ff ff       	jmp    801057dd <alltraps>

80105d9f <vector33>:
80105d9f:	6a 00                	push   $0x0
80105da1:	6a 21                	push   $0x21
80105da3:	e9 35 fa ff ff       	jmp    801057dd <alltraps>

80105da8 <vector34>:
80105da8:	6a 00                	push   $0x0
80105daa:	6a 22                	push   $0x22
80105dac:	e9 2c fa ff ff       	jmp    801057dd <alltraps>

80105db1 <vector35>:
80105db1:	6a 00                	push   $0x0
80105db3:	6a 23                	push   $0x23
80105db5:	e9 23 fa ff ff       	jmp    801057dd <alltraps>

80105dba <vector36>:
80105dba:	6a 00                	push   $0x0
80105dbc:	6a 24                	push   $0x24
80105dbe:	e9 1a fa ff ff       	jmp    801057dd <alltraps>

80105dc3 <vector37>:
80105dc3:	6a 00                	push   $0x0
80105dc5:	6a 25                	push   $0x25
80105dc7:	e9 11 fa ff ff       	jmp    801057dd <alltraps>

80105dcc <vector38>:
80105dcc:	6a 00                	push   $0x0
80105dce:	6a 26                	push   $0x26
80105dd0:	e9 08 fa ff ff       	jmp    801057dd <alltraps>

80105dd5 <vector39>:
80105dd5:	6a 00                	push   $0x0
80105dd7:	6a 27                	push   $0x27
80105dd9:	e9 ff f9 ff ff       	jmp    801057dd <alltraps>

80105dde <vector40>:
80105dde:	6a 00                	push   $0x0
80105de0:	6a 28                	push   $0x28
80105de2:	e9 f6 f9 ff ff       	jmp    801057dd <alltraps>

80105de7 <vector41>:
80105de7:	6a 00                	push   $0x0
80105de9:	6a 29                	push   $0x29
80105deb:	e9 ed f9 ff ff       	jmp    801057dd <alltraps>

80105df0 <vector42>:
80105df0:	6a 00                	push   $0x0
80105df2:	6a 2a                	push   $0x2a
80105df4:	e9 e4 f9 ff ff       	jmp    801057dd <alltraps>

80105df9 <vector43>:
80105df9:	6a 00                	push   $0x0
80105dfb:	6a 2b                	push   $0x2b
80105dfd:	e9 db f9 ff ff       	jmp    801057dd <alltraps>

80105e02 <vector44>:
80105e02:	6a 00                	push   $0x0
80105e04:	6a 2c                	push   $0x2c
80105e06:	e9 d2 f9 ff ff       	jmp    801057dd <alltraps>

80105e0b <vector45>:
80105e0b:	6a 00                	push   $0x0
80105e0d:	6a 2d                	push   $0x2d
80105e0f:	e9 c9 f9 ff ff       	jmp    801057dd <alltraps>

80105e14 <vector46>:
80105e14:	6a 00                	push   $0x0
80105e16:	6a 2e                	push   $0x2e
80105e18:	e9 c0 f9 ff ff       	jmp    801057dd <alltraps>

80105e1d <vector47>:
80105e1d:	6a 00                	push   $0x0
80105e1f:	6a 2f                	push   $0x2f
80105e21:	e9 b7 f9 ff ff       	jmp    801057dd <alltraps>

80105e26 <vector48>:
80105e26:	6a 00                	push   $0x0
80105e28:	6a 30                	push   $0x30
80105e2a:	e9 ae f9 ff ff       	jmp    801057dd <alltraps>

80105e2f <vector49>:
80105e2f:	6a 00                	push   $0x0
80105e31:	6a 31                	push   $0x31
80105e33:	e9 a5 f9 ff ff       	jmp    801057dd <alltraps>

80105e38 <vector50>:
80105e38:	6a 00                	push   $0x0
80105e3a:	6a 32                	push   $0x32
80105e3c:	e9 9c f9 ff ff       	jmp    801057dd <alltraps>

80105e41 <vector51>:
80105e41:	6a 00                	push   $0x0
80105e43:	6a 33                	push   $0x33
80105e45:	e9 93 f9 ff ff       	jmp    801057dd <alltraps>

80105e4a <vector52>:
80105e4a:	6a 00                	push   $0x0
80105e4c:	6a 34                	push   $0x34
80105e4e:	e9 8a f9 ff ff       	jmp    801057dd <alltraps>

80105e53 <vector53>:
80105e53:	6a 00                	push   $0x0
80105e55:	6a 35                	push   $0x35
80105e57:	e9 81 f9 ff ff       	jmp    801057dd <alltraps>

80105e5c <vector54>:
80105e5c:	6a 00                	push   $0x0
80105e5e:	6a 36                	push   $0x36
80105e60:	e9 78 f9 ff ff       	jmp    801057dd <alltraps>

80105e65 <vector55>:
80105e65:	6a 00                	push   $0x0
80105e67:	6a 37                	push   $0x37
80105e69:	e9 6f f9 ff ff       	jmp    801057dd <alltraps>

80105e6e <vector56>:
80105e6e:	6a 00                	push   $0x0
80105e70:	6a 38                	push   $0x38
80105e72:	e9 66 f9 ff ff       	jmp    801057dd <alltraps>

80105e77 <vector57>:
80105e77:	6a 00                	push   $0x0
80105e79:	6a 39                	push   $0x39
80105e7b:	e9 5d f9 ff ff       	jmp    801057dd <alltraps>

80105e80 <vector58>:
80105e80:	6a 00                	push   $0x0
80105e82:	6a 3a                	push   $0x3a
80105e84:	e9 54 f9 ff ff       	jmp    801057dd <alltraps>

80105e89 <vector59>:
80105e89:	6a 00                	push   $0x0
80105e8b:	6a 3b                	push   $0x3b
80105e8d:	e9 4b f9 ff ff       	jmp    801057dd <alltraps>

80105e92 <vector60>:
80105e92:	6a 00                	push   $0x0
80105e94:	6a 3c                	push   $0x3c
80105e96:	e9 42 f9 ff ff       	jmp    801057dd <alltraps>

80105e9b <vector61>:
80105e9b:	6a 00                	push   $0x0
80105e9d:	6a 3d                	push   $0x3d
80105e9f:	e9 39 f9 ff ff       	jmp    801057dd <alltraps>

80105ea4 <vector62>:
80105ea4:	6a 00                	push   $0x0
80105ea6:	6a 3e                	push   $0x3e
80105ea8:	e9 30 f9 ff ff       	jmp    801057dd <alltraps>

80105ead <vector63>:
80105ead:	6a 00                	push   $0x0
80105eaf:	6a 3f                	push   $0x3f
80105eb1:	e9 27 f9 ff ff       	jmp    801057dd <alltraps>

80105eb6 <vector64>:
80105eb6:	6a 00                	push   $0x0
80105eb8:	6a 40                	push   $0x40
80105eba:	e9 1e f9 ff ff       	jmp    801057dd <alltraps>

80105ebf <vector65>:
80105ebf:	6a 00                	push   $0x0
80105ec1:	6a 41                	push   $0x41
80105ec3:	e9 15 f9 ff ff       	jmp    801057dd <alltraps>

80105ec8 <vector66>:
80105ec8:	6a 00                	push   $0x0
80105eca:	6a 42                	push   $0x42
80105ecc:	e9 0c f9 ff ff       	jmp    801057dd <alltraps>

80105ed1 <vector67>:
80105ed1:	6a 00                	push   $0x0
80105ed3:	6a 43                	push   $0x43
80105ed5:	e9 03 f9 ff ff       	jmp    801057dd <alltraps>

80105eda <vector68>:
80105eda:	6a 00                	push   $0x0
80105edc:	6a 44                	push   $0x44
80105ede:	e9 fa f8 ff ff       	jmp    801057dd <alltraps>

80105ee3 <vector69>:
80105ee3:	6a 00                	push   $0x0
80105ee5:	6a 45                	push   $0x45
80105ee7:	e9 f1 f8 ff ff       	jmp    801057dd <alltraps>

80105eec <vector70>:
80105eec:	6a 00                	push   $0x0
80105eee:	6a 46                	push   $0x46
80105ef0:	e9 e8 f8 ff ff       	jmp    801057dd <alltraps>

80105ef5 <vector71>:
80105ef5:	6a 00                	push   $0x0
80105ef7:	6a 47                	push   $0x47
80105ef9:	e9 df f8 ff ff       	jmp    801057dd <alltraps>

80105efe <vector72>:
80105efe:	6a 00                	push   $0x0
80105f00:	6a 48                	push   $0x48
80105f02:	e9 d6 f8 ff ff       	jmp    801057dd <alltraps>

80105f07 <vector73>:
80105f07:	6a 00                	push   $0x0
80105f09:	6a 49                	push   $0x49
80105f0b:	e9 cd f8 ff ff       	jmp    801057dd <alltraps>

80105f10 <vector74>:
80105f10:	6a 00                	push   $0x0
80105f12:	6a 4a                	push   $0x4a
80105f14:	e9 c4 f8 ff ff       	jmp    801057dd <alltraps>

80105f19 <vector75>:
80105f19:	6a 00                	push   $0x0
80105f1b:	6a 4b                	push   $0x4b
80105f1d:	e9 bb f8 ff ff       	jmp    801057dd <alltraps>

80105f22 <vector76>:
80105f22:	6a 00                	push   $0x0
80105f24:	6a 4c                	push   $0x4c
80105f26:	e9 b2 f8 ff ff       	jmp    801057dd <alltraps>

80105f2b <vector77>:
80105f2b:	6a 00                	push   $0x0
80105f2d:	6a 4d                	push   $0x4d
80105f2f:	e9 a9 f8 ff ff       	jmp    801057dd <alltraps>

80105f34 <vector78>:
80105f34:	6a 00                	push   $0x0
80105f36:	6a 4e                	push   $0x4e
80105f38:	e9 a0 f8 ff ff       	jmp    801057dd <alltraps>

80105f3d <vector79>:
80105f3d:	6a 00                	push   $0x0
80105f3f:	6a 4f                	push   $0x4f
80105f41:	e9 97 f8 ff ff       	jmp    801057dd <alltraps>

80105f46 <vector80>:
80105f46:	6a 00                	push   $0x0
80105f48:	6a 50                	push   $0x50
80105f4a:	e9 8e f8 ff ff       	jmp    801057dd <alltraps>

80105f4f <vector81>:
80105f4f:	6a 00                	push   $0x0
80105f51:	6a 51                	push   $0x51
80105f53:	e9 85 f8 ff ff       	jmp    801057dd <alltraps>

80105f58 <vector82>:
80105f58:	6a 00                	push   $0x0
80105f5a:	6a 52                	push   $0x52
80105f5c:	e9 7c f8 ff ff       	jmp    801057dd <alltraps>

80105f61 <vector83>:
80105f61:	6a 00                	push   $0x0
80105f63:	6a 53                	push   $0x53
80105f65:	e9 73 f8 ff ff       	jmp    801057dd <alltraps>

80105f6a <vector84>:
80105f6a:	6a 00                	push   $0x0
80105f6c:	6a 54                	push   $0x54
80105f6e:	e9 6a f8 ff ff       	jmp    801057dd <alltraps>

80105f73 <vector85>:
80105f73:	6a 00                	push   $0x0
80105f75:	6a 55                	push   $0x55
80105f77:	e9 61 f8 ff ff       	jmp    801057dd <alltraps>

80105f7c <vector86>:
80105f7c:	6a 00                	push   $0x0
80105f7e:	6a 56                	push   $0x56
80105f80:	e9 58 f8 ff ff       	jmp    801057dd <alltraps>

80105f85 <vector87>:
80105f85:	6a 00                	push   $0x0
80105f87:	6a 57                	push   $0x57
80105f89:	e9 4f f8 ff ff       	jmp    801057dd <alltraps>

80105f8e <vector88>:
80105f8e:	6a 00                	push   $0x0
80105f90:	6a 58                	push   $0x58
80105f92:	e9 46 f8 ff ff       	jmp    801057dd <alltraps>

80105f97 <vector89>:
80105f97:	6a 00                	push   $0x0
80105f99:	6a 59                	push   $0x59
80105f9b:	e9 3d f8 ff ff       	jmp    801057dd <alltraps>

80105fa0 <vector90>:
80105fa0:	6a 00                	push   $0x0
80105fa2:	6a 5a                	push   $0x5a
80105fa4:	e9 34 f8 ff ff       	jmp    801057dd <alltraps>

80105fa9 <vector91>:
80105fa9:	6a 00                	push   $0x0
80105fab:	6a 5b                	push   $0x5b
80105fad:	e9 2b f8 ff ff       	jmp    801057dd <alltraps>

80105fb2 <vector92>:
80105fb2:	6a 00                	push   $0x0
80105fb4:	6a 5c                	push   $0x5c
80105fb6:	e9 22 f8 ff ff       	jmp    801057dd <alltraps>

80105fbb <vector93>:
80105fbb:	6a 00                	push   $0x0
80105fbd:	6a 5d                	push   $0x5d
80105fbf:	e9 19 f8 ff ff       	jmp    801057dd <alltraps>

80105fc4 <vector94>:
80105fc4:	6a 00                	push   $0x0
80105fc6:	6a 5e                	push   $0x5e
80105fc8:	e9 10 f8 ff ff       	jmp    801057dd <alltraps>

80105fcd <vector95>:
80105fcd:	6a 00                	push   $0x0
80105fcf:	6a 5f                	push   $0x5f
80105fd1:	e9 07 f8 ff ff       	jmp    801057dd <alltraps>

80105fd6 <vector96>:
80105fd6:	6a 00                	push   $0x0
80105fd8:	6a 60                	push   $0x60
80105fda:	e9 fe f7 ff ff       	jmp    801057dd <alltraps>

80105fdf <vector97>:
80105fdf:	6a 00                	push   $0x0
80105fe1:	6a 61                	push   $0x61
80105fe3:	e9 f5 f7 ff ff       	jmp    801057dd <alltraps>

80105fe8 <vector98>:
80105fe8:	6a 00                	push   $0x0
80105fea:	6a 62                	push   $0x62
80105fec:	e9 ec f7 ff ff       	jmp    801057dd <alltraps>

80105ff1 <vector99>:
80105ff1:	6a 00                	push   $0x0
80105ff3:	6a 63                	push   $0x63
80105ff5:	e9 e3 f7 ff ff       	jmp    801057dd <alltraps>

80105ffa <vector100>:
80105ffa:	6a 00                	push   $0x0
80105ffc:	6a 64                	push   $0x64
80105ffe:	e9 da f7 ff ff       	jmp    801057dd <alltraps>

80106003 <vector101>:
80106003:	6a 00                	push   $0x0
80106005:	6a 65                	push   $0x65
80106007:	e9 d1 f7 ff ff       	jmp    801057dd <alltraps>

8010600c <vector102>:
8010600c:	6a 00                	push   $0x0
8010600e:	6a 66                	push   $0x66
80106010:	e9 c8 f7 ff ff       	jmp    801057dd <alltraps>

80106015 <vector103>:
80106015:	6a 00                	push   $0x0
80106017:	6a 67                	push   $0x67
80106019:	e9 bf f7 ff ff       	jmp    801057dd <alltraps>

8010601e <vector104>:
8010601e:	6a 00                	push   $0x0
80106020:	6a 68                	push   $0x68
80106022:	e9 b6 f7 ff ff       	jmp    801057dd <alltraps>

80106027 <vector105>:
80106027:	6a 00                	push   $0x0
80106029:	6a 69                	push   $0x69
8010602b:	e9 ad f7 ff ff       	jmp    801057dd <alltraps>

80106030 <vector106>:
80106030:	6a 00                	push   $0x0
80106032:	6a 6a                	push   $0x6a
80106034:	e9 a4 f7 ff ff       	jmp    801057dd <alltraps>

80106039 <vector107>:
80106039:	6a 00                	push   $0x0
8010603b:	6a 6b                	push   $0x6b
8010603d:	e9 9b f7 ff ff       	jmp    801057dd <alltraps>

80106042 <vector108>:
80106042:	6a 00                	push   $0x0
80106044:	6a 6c                	push   $0x6c
80106046:	e9 92 f7 ff ff       	jmp    801057dd <alltraps>

8010604b <vector109>:
8010604b:	6a 00                	push   $0x0
8010604d:	6a 6d                	push   $0x6d
8010604f:	e9 89 f7 ff ff       	jmp    801057dd <alltraps>

80106054 <vector110>:
80106054:	6a 00                	push   $0x0
80106056:	6a 6e                	push   $0x6e
80106058:	e9 80 f7 ff ff       	jmp    801057dd <alltraps>

8010605d <vector111>:
8010605d:	6a 00                	push   $0x0
8010605f:	6a 6f                	push   $0x6f
80106061:	e9 77 f7 ff ff       	jmp    801057dd <alltraps>

80106066 <vector112>:
80106066:	6a 00                	push   $0x0
80106068:	6a 70                	push   $0x70
8010606a:	e9 6e f7 ff ff       	jmp    801057dd <alltraps>

8010606f <vector113>:
8010606f:	6a 00                	push   $0x0
80106071:	6a 71                	push   $0x71
80106073:	e9 65 f7 ff ff       	jmp    801057dd <alltraps>

80106078 <vector114>:
80106078:	6a 00                	push   $0x0
8010607a:	6a 72                	push   $0x72
8010607c:	e9 5c f7 ff ff       	jmp    801057dd <alltraps>

80106081 <vector115>:
80106081:	6a 00                	push   $0x0
80106083:	6a 73                	push   $0x73
80106085:	e9 53 f7 ff ff       	jmp    801057dd <alltraps>

8010608a <vector116>:
8010608a:	6a 00                	push   $0x0
8010608c:	6a 74                	push   $0x74
8010608e:	e9 4a f7 ff ff       	jmp    801057dd <alltraps>

80106093 <vector117>:
80106093:	6a 00                	push   $0x0
80106095:	6a 75                	push   $0x75
80106097:	e9 41 f7 ff ff       	jmp    801057dd <alltraps>

8010609c <vector118>:
8010609c:	6a 00                	push   $0x0
8010609e:	6a 76                	push   $0x76
801060a0:	e9 38 f7 ff ff       	jmp    801057dd <alltraps>

801060a5 <vector119>:
801060a5:	6a 00                	push   $0x0
801060a7:	6a 77                	push   $0x77
801060a9:	e9 2f f7 ff ff       	jmp    801057dd <alltraps>

801060ae <vector120>:
801060ae:	6a 00                	push   $0x0
801060b0:	6a 78                	push   $0x78
801060b2:	e9 26 f7 ff ff       	jmp    801057dd <alltraps>

801060b7 <vector121>:
801060b7:	6a 00                	push   $0x0
801060b9:	6a 79                	push   $0x79
801060bb:	e9 1d f7 ff ff       	jmp    801057dd <alltraps>

801060c0 <vector122>:
801060c0:	6a 00                	push   $0x0
801060c2:	6a 7a                	push   $0x7a
801060c4:	e9 14 f7 ff ff       	jmp    801057dd <alltraps>

801060c9 <vector123>:
801060c9:	6a 00                	push   $0x0
801060cb:	6a 7b                	push   $0x7b
801060cd:	e9 0b f7 ff ff       	jmp    801057dd <alltraps>

801060d2 <vector124>:
801060d2:	6a 00                	push   $0x0
801060d4:	6a 7c                	push   $0x7c
801060d6:	e9 02 f7 ff ff       	jmp    801057dd <alltraps>

801060db <vector125>:
801060db:	6a 00                	push   $0x0
801060dd:	6a 7d                	push   $0x7d
801060df:	e9 f9 f6 ff ff       	jmp    801057dd <alltraps>

801060e4 <vector126>:
801060e4:	6a 00                	push   $0x0
801060e6:	6a 7e                	push   $0x7e
801060e8:	e9 f0 f6 ff ff       	jmp    801057dd <alltraps>

801060ed <vector127>:
801060ed:	6a 00                	push   $0x0
801060ef:	6a 7f                	push   $0x7f
801060f1:	e9 e7 f6 ff ff       	jmp    801057dd <alltraps>

801060f6 <vector128>:
801060f6:	6a 00                	push   $0x0
801060f8:	68 80 00 00 00       	push   $0x80
801060fd:	e9 db f6 ff ff       	jmp    801057dd <alltraps>

80106102 <vector129>:
80106102:	6a 00                	push   $0x0
80106104:	68 81 00 00 00       	push   $0x81
80106109:	e9 cf f6 ff ff       	jmp    801057dd <alltraps>

8010610e <vector130>:
8010610e:	6a 00                	push   $0x0
80106110:	68 82 00 00 00       	push   $0x82
80106115:	e9 c3 f6 ff ff       	jmp    801057dd <alltraps>

8010611a <vector131>:
8010611a:	6a 00                	push   $0x0
8010611c:	68 83 00 00 00       	push   $0x83
80106121:	e9 b7 f6 ff ff       	jmp    801057dd <alltraps>

80106126 <vector132>:
80106126:	6a 00                	push   $0x0
80106128:	68 84 00 00 00       	push   $0x84
8010612d:	e9 ab f6 ff ff       	jmp    801057dd <alltraps>

80106132 <vector133>:
80106132:	6a 00                	push   $0x0
80106134:	68 85 00 00 00       	push   $0x85
80106139:	e9 9f f6 ff ff       	jmp    801057dd <alltraps>

8010613e <vector134>:
8010613e:	6a 00                	push   $0x0
80106140:	68 86 00 00 00       	push   $0x86
80106145:	e9 93 f6 ff ff       	jmp    801057dd <alltraps>

8010614a <vector135>:
8010614a:	6a 00                	push   $0x0
8010614c:	68 87 00 00 00       	push   $0x87
80106151:	e9 87 f6 ff ff       	jmp    801057dd <alltraps>

80106156 <vector136>:
80106156:	6a 00                	push   $0x0
80106158:	68 88 00 00 00       	push   $0x88
8010615d:	e9 7b f6 ff ff       	jmp    801057dd <alltraps>

80106162 <vector137>:
80106162:	6a 00                	push   $0x0
80106164:	68 89 00 00 00       	push   $0x89
80106169:	e9 6f f6 ff ff       	jmp    801057dd <alltraps>

8010616e <vector138>:
8010616e:	6a 00                	push   $0x0
80106170:	68 8a 00 00 00       	push   $0x8a
80106175:	e9 63 f6 ff ff       	jmp    801057dd <alltraps>

8010617a <vector139>:
8010617a:	6a 00                	push   $0x0
8010617c:	68 8b 00 00 00       	push   $0x8b
80106181:	e9 57 f6 ff ff       	jmp    801057dd <alltraps>

80106186 <vector140>:
80106186:	6a 00                	push   $0x0
80106188:	68 8c 00 00 00       	push   $0x8c
8010618d:	e9 4b f6 ff ff       	jmp    801057dd <alltraps>

80106192 <vector141>:
80106192:	6a 00                	push   $0x0
80106194:	68 8d 00 00 00       	push   $0x8d
80106199:	e9 3f f6 ff ff       	jmp    801057dd <alltraps>

8010619e <vector142>:
8010619e:	6a 00                	push   $0x0
801061a0:	68 8e 00 00 00       	push   $0x8e
801061a5:	e9 33 f6 ff ff       	jmp    801057dd <alltraps>

801061aa <vector143>:
801061aa:	6a 00                	push   $0x0
801061ac:	68 8f 00 00 00       	push   $0x8f
801061b1:	e9 27 f6 ff ff       	jmp    801057dd <alltraps>

801061b6 <vector144>:
801061b6:	6a 00                	push   $0x0
801061b8:	68 90 00 00 00       	push   $0x90
801061bd:	e9 1b f6 ff ff       	jmp    801057dd <alltraps>

801061c2 <vector145>:
801061c2:	6a 00                	push   $0x0
801061c4:	68 91 00 00 00       	push   $0x91
801061c9:	e9 0f f6 ff ff       	jmp    801057dd <alltraps>

801061ce <vector146>:
801061ce:	6a 00                	push   $0x0
801061d0:	68 92 00 00 00       	push   $0x92
801061d5:	e9 03 f6 ff ff       	jmp    801057dd <alltraps>

801061da <vector147>:
801061da:	6a 00                	push   $0x0
801061dc:	68 93 00 00 00       	push   $0x93
801061e1:	e9 f7 f5 ff ff       	jmp    801057dd <alltraps>

801061e6 <vector148>:
801061e6:	6a 00                	push   $0x0
801061e8:	68 94 00 00 00       	push   $0x94
801061ed:	e9 eb f5 ff ff       	jmp    801057dd <alltraps>

801061f2 <vector149>:
801061f2:	6a 00                	push   $0x0
801061f4:	68 95 00 00 00       	push   $0x95
801061f9:	e9 df f5 ff ff       	jmp    801057dd <alltraps>

801061fe <vector150>:
801061fe:	6a 00                	push   $0x0
80106200:	68 96 00 00 00       	push   $0x96
80106205:	e9 d3 f5 ff ff       	jmp    801057dd <alltraps>

8010620a <vector151>:
8010620a:	6a 00                	push   $0x0
8010620c:	68 97 00 00 00       	push   $0x97
80106211:	e9 c7 f5 ff ff       	jmp    801057dd <alltraps>

80106216 <vector152>:
80106216:	6a 00                	push   $0x0
80106218:	68 98 00 00 00       	push   $0x98
8010621d:	e9 bb f5 ff ff       	jmp    801057dd <alltraps>

80106222 <vector153>:
80106222:	6a 00                	push   $0x0
80106224:	68 99 00 00 00       	push   $0x99
80106229:	e9 af f5 ff ff       	jmp    801057dd <alltraps>

8010622e <vector154>:
8010622e:	6a 00                	push   $0x0
80106230:	68 9a 00 00 00       	push   $0x9a
80106235:	e9 a3 f5 ff ff       	jmp    801057dd <alltraps>

8010623a <vector155>:
8010623a:	6a 00                	push   $0x0
8010623c:	68 9b 00 00 00       	push   $0x9b
80106241:	e9 97 f5 ff ff       	jmp    801057dd <alltraps>

80106246 <vector156>:
80106246:	6a 00                	push   $0x0
80106248:	68 9c 00 00 00       	push   $0x9c
8010624d:	e9 8b f5 ff ff       	jmp    801057dd <alltraps>

80106252 <vector157>:
80106252:	6a 00                	push   $0x0
80106254:	68 9d 00 00 00       	push   $0x9d
80106259:	e9 7f f5 ff ff       	jmp    801057dd <alltraps>

8010625e <vector158>:
8010625e:	6a 00                	push   $0x0
80106260:	68 9e 00 00 00       	push   $0x9e
80106265:	e9 73 f5 ff ff       	jmp    801057dd <alltraps>

8010626a <vector159>:
8010626a:	6a 00                	push   $0x0
8010626c:	68 9f 00 00 00       	push   $0x9f
80106271:	e9 67 f5 ff ff       	jmp    801057dd <alltraps>

80106276 <vector160>:
80106276:	6a 00                	push   $0x0
80106278:	68 a0 00 00 00       	push   $0xa0
8010627d:	e9 5b f5 ff ff       	jmp    801057dd <alltraps>

80106282 <vector161>:
80106282:	6a 00                	push   $0x0
80106284:	68 a1 00 00 00       	push   $0xa1
80106289:	e9 4f f5 ff ff       	jmp    801057dd <alltraps>

8010628e <vector162>:
8010628e:	6a 00                	push   $0x0
80106290:	68 a2 00 00 00       	push   $0xa2
80106295:	e9 43 f5 ff ff       	jmp    801057dd <alltraps>

8010629a <vector163>:
8010629a:	6a 00                	push   $0x0
8010629c:	68 a3 00 00 00       	push   $0xa3
801062a1:	e9 37 f5 ff ff       	jmp    801057dd <alltraps>

801062a6 <vector164>:
801062a6:	6a 00                	push   $0x0
801062a8:	68 a4 00 00 00       	push   $0xa4
801062ad:	e9 2b f5 ff ff       	jmp    801057dd <alltraps>

801062b2 <vector165>:
801062b2:	6a 00                	push   $0x0
801062b4:	68 a5 00 00 00       	push   $0xa5
801062b9:	e9 1f f5 ff ff       	jmp    801057dd <alltraps>

801062be <vector166>:
801062be:	6a 00                	push   $0x0
801062c0:	68 a6 00 00 00       	push   $0xa6
801062c5:	e9 13 f5 ff ff       	jmp    801057dd <alltraps>

801062ca <vector167>:
801062ca:	6a 00                	push   $0x0
801062cc:	68 a7 00 00 00       	push   $0xa7
801062d1:	e9 07 f5 ff ff       	jmp    801057dd <alltraps>

801062d6 <vector168>:
801062d6:	6a 00                	push   $0x0
801062d8:	68 a8 00 00 00       	push   $0xa8
801062dd:	e9 fb f4 ff ff       	jmp    801057dd <alltraps>

801062e2 <vector169>:
801062e2:	6a 00                	push   $0x0
801062e4:	68 a9 00 00 00       	push   $0xa9
801062e9:	e9 ef f4 ff ff       	jmp    801057dd <alltraps>

801062ee <vector170>:
801062ee:	6a 00                	push   $0x0
801062f0:	68 aa 00 00 00       	push   $0xaa
801062f5:	e9 e3 f4 ff ff       	jmp    801057dd <alltraps>

801062fa <vector171>:
801062fa:	6a 00                	push   $0x0
801062fc:	68 ab 00 00 00       	push   $0xab
80106301:	e9 d7 f4 ff ff       	jmp    801057dd <alltraps>

80106306 <vector172>:
80106306:	6a 00                	push   $0x0
80106308:	68 ac 00 00 00       	push   $0xac
8010630d:	e9 cb f4 ff ff       	jmp    801057dd <alltraps>

80106312 <vector173>:
80106312:	6a 00                	push   $0x0
80106314:	68 ad 00 00 00       	push   $0xad
80106319:	e9 bf f4 ff ff       	jmp    801057dd <alltraps>

8010631e <vector174>:
8010631e:	6a 00                	push   $0x0
80106320:	68 ae 00 00 00       	push   $0xae
80106325:	e9 b3 f4 ff ff       	jmp    801057dd <alltraps>

8010632a <vector175>:
8010632a:	6a 00                	push   $0x0
8010632c:	68 af 00 00 00       	push   $0xaf
80106331:	e9 a7 f4 ff ff       	jmp    801057dd <alltraps>

80106336 <vector176>:
80106336:	6a 00                	push   $0x0
80106338:	68 b0 00 00 00       	push   $0xb0
8010633d:	e9 9b f4 ff ff       	jmp    801057dd <alltraps>

80106342 <vector177>:
80106342:	6a 00                	push   $0x0
80106344:	68 b1 00 00 00       	push   $0xb1
80106349:	e9 8f f4 ff ff       	jmp    801057dd <alltraps>

8010634e <vector178>:
8010634e:	6a 00                	push   $0x0
80106350:	68 b2 00 00 00       	push   $0xb2
80106355:	e9 83 f4 ff ff       	jmp    801057dd <alltraps>

8010635a <vector179>:
8010635a:	6a 00                	push   $0x0
8010635c:	68 b3 00 00 00       	push   $0xb3
80106361:	e9 77 f4 ff ff       	jmp    801057dd <alltraps>

80106366 <vector180>:
80106366:	6a 00                	push   $0x0
80106368:	68 b4 00 00 00       	push   $0xb4
8010636d:	e9 6b f4 ff ff       	jmp    801057dd <alltraps>

80106372 <vector181>:
80106372:	6a 00                	push   $0x0
80106374:	68 b5 00 00 00       	push   $0xb5
80106379:	e9 5f f4 ff ff       	jmp    801057dd <alltraps>

8010637e <vector182>:
8010637e:	6a 00                	push   $0x0
80106380:	68 b6 00 00 00       	push   $0xb6
80106385:	e9 53 f4 ff ff       	jmp    801057dd <alltraps>

8010638a <vector183>:
8010638a:	6a 00                	push   $0x0
8010638c:	68 b7 00 00 00       	push   $0xb7
80106391:	e9 47 f4 ff ff       	jmp    801057dd <alltraps>

80106396 <vector184>:
80106396:	6a 00                	push   $0x0
80106398:	68 b8 00 00 00       	push   $0xb8
8010639d:	e9 3b f4 ff ff       	jmp    801057dd <alltraps>

801063a2 <vector185>:
801063a2:	6a 00                	push   $0x0
801063a4:	68 b9 00 00 00       	push   $0xb9
801063a9:	e9 2f f4 ff ff       	jmp    801057dd <alltraps>

801063ae <vector186>:
801063ae:	6a 00                	push   $0x0
801063b0:	68 ba 00 00 00       	push   $0xba
801063b5:	e9 23 f4 ff ff       	jmp    801057dd <alltraps>

801063ba <vector187>:
801063ba:	6a 00                	push   $0x0
801063bc:	68 bb 00 00 00       	push   $0xbb
801063c1:	e9 17 f4 ff ff       	jmp    801057dd <alltraps>

801063c6 <vector188>:
801063c6:	6a 00                	push   $0x0
801063c8:	68 bc 00 00 00       	push   $0xbc
801063cd:	e9 0b f4 ff ff       	jmp    801057dd <alltraps>

801063d2 <vector189>:
801063d2:	6a 00                	push   $0x0
801063d4:	68 bd 00 00 00       	push   $0xbd
801063d9:	e9 ff f3 ff ff       	jmp    801057dd <alltraps>

801063de <vector190>:
801063de:	6a 00                	push   $0x0
801063e0:	68 be 00 00 00       	push   $0xbe
801063e5:	e9 f3 f3 ff ff       	jmp    801057dd <alltraps>

801063ea <vector191>:
801063ea:	6a 00                	push   $0x0
801063ec:	68 bf 00 00 00       	push   $0xbf
801063f1:	e9 e7 f3 ff ff       	jmp    801057dd <alltraps>

801063f6 <vector192>:
801063f6:	6a 00                	push   $0x0
801063f8:	68 c0 00 00 00       	push   $0xc0
801063fd:	e9 db f3 ff ff       	jmp    801057dd <alltraps>

80106402 <vector193>:
80106402:	6a 00                	push   $0x0
80106404:	68 c1 00 00 00       	push   $0xc1
80106409:	e9 cf f3 ff ff       	jmp    801057dd <alltraps>

8010640e <vector194>:
8010640e:	6a 00                	push   $0x0
80106410:	68 c2 00 00 00       	push   $0xc2
80106415:	e9 c3 f3 ff ff       	jmp    801057dd <alltraps>

8010641a <vector195>:
8010641a:	6a 00                	push   $0x0
8010641c:	68 c3 00 00 00       	push   $0xc3
80106421:	e9 b7 f3 ff ff       	jmp    801057dd <alltraps>

80106426 <vector196>:
80106426:	6a 00                	push   $0x0
80106428:	68 c4 00 00 00       	push   $0xc4
8010642d:	e9 ab f3 ff ff       	jmp    801057dd <alltraps>

80106432 <vector197>:
80106432:	6a 00                	push   $0x0
80106434:	68 c5 00 00 00       	push   $0xc5
80106439:	e9 9f f3 ff ff       	jmp    801057dd <alltraps>

8010643e <vector198>:
8010643e:	6a 00                	push   $0x0
80106440:	68 c6 00 00 00       	push   $0xc6
80106445:	e9 93 f3 ff ff       	jmp    801057dd <alltraps>

8010644a <vector199>:
8010644a:	6a 00                	push   $0x0
8010644c:	68 c7 00 00 00       	push   $0xc7
80106451:	e9 87 f3 ff ff       	jmp    801057dd <alltraps>

80106456 <vector200>:
80106456:	6a 00                	push   $0x0
80106458:	68 c8 00 00 00       	push   $0xc8
8010645d:	e9 7b f3 ff ff       	jmp    801057dd <alltraps>

80106462 <vector201>:
80106462:	6a 00                	push   $0x0
80106464:	68 c9 00 00 00       	push   $0xc9
80106469:	e9 6f f3 ff ff       	jmp    801057dd <alltraps>

8010646e <vector202>:
8010646e:	6a 00                	push   $0x0
80106470:	68 ca 00 00 00       	push   $0xca
80106475:	e9 63 f3 ff ff       	jmp    801057dd <alltraps>

8010647a <vector203>:
8010647a:	6a 00                	push   $0x0
8010647c:	68 cb 00 00 00       	push   $0xcb
80106481:	e9 57 f3 ff ff       	jmp    801057dd <alltraps>

80106486 <vector204>:
80106486:	6a 00                	push   $0x0
80106488:	68 cc 00 00 00       	push   $0xcc
8010648d:	e9 4b f3 ff ff       	jmp    801057dd <alltraps>

80106492 <vector205>:
80106492:	6a 00                	push   $0x0
80106494:	68 cd 00 00 00       	push   $0xcd
80106499:	e9 3f f3 ff ff       	jmp    801057dd <alltraps>

8010649e <vector206>:
8010649e:	6a 00                	push   $0x0
801064a0:	68 ce 00 00 00       	push   $0xce
801064a5:	e9 33 f3 ff ff       	jmp    801057dd <alltraps>

801064aa <vector207>:
801064aa:	6a 00                	push   $0x0
801064ac:	68 cf 00 00 00       	push   $0xcf
801064b1:	e9 27 f3 ff ff       	jmp    801057dd <alltraps>

801064b6 <vector208>:
801064b6:	6a 00                	push   $0x0
801064b8:	68 d0 00 00 00       	push   $0xd0
801064bd:	e9 1b f3 ff ff       	jmp    801057dd <alltraps>

801064c2 <vector209>:
801064c2:	6a 00                	push   $0x0
801064c4:	68 d1 00 00 00       	push   $0xd1
801064c9:	e9 0f f3 ff ff       	jmp    801057dd <alltraps>

801064ce <vector210>:
801064ce:	6a 00                	push   $0x0
801064d0:	68 d2 00 00 00       	push   $0xd2
801064d5:	e9 03 f3 ff ff       	jmp    801057dd <alltraps>

801064da <vector211>:
801064da:	6a 00                	push   $0x0
801064dc:	68 d3 00 00 00       	push   $0xd3
801064e1:	e9 f7 f2 ff ff       	jmp    801057dd <alltraps>

801064e6 <vector212>:
801064e6:	6a 00                	push   $0x0
801064e8:	68 d4 00 00 00       	push   $0xd4
801064ed:	e9 eb f2 ff ff       	jmp    801057dd <alltraps>

801064f2 <vector213>:
801064f2:	6a 00                	push   $0x0
801064f4:	68 d5 00 00 00       	push   $0xd5
801064f9:	e9 df f2 ff ff       	jmp    801057dd <alltraps>

801064fe <vector214>:
801064fe:	6a 00                	push   $0x0
80106500:	68 d6 00 00 00       	push   $0xd6
80106505:	e9 d3 f2 ff ff       	jmp    801057dd <alltraps>

8010650a <vector215>:
8010650a:	6a 00                	push   $0x0
8010650c:	68 d7 00 00 00       	push   $0xd7
80106511:	e9 c7 f2 ff ff       	jmp    801057dd <alltraps>

80106516 <vector216>:
80106516:	6a 00                	push   $0x0
80106518:	68 d8 00 00 00       	push   $0xd8
8010651d:	e9 bb f2 ff ff       	jmp    801057dd <alltraps>

80106522 <vector217>:
80106522:	6a 00                	push   $0x0
80106524:	68 d9 00 00 00       	push   $0xd9
80106529:	e9 af f2 ff ff       	jmp    801057dd <alltraps>

8010652e <vector218>:
8010652e:	6a 00                	push   $0x0
80106530:	68 da 00 00 00       	push   $0xda
80106535:	e9 a3 f2 ff ff       	jmp    801057dd <alltraps>

8010653a <vector219>:
8010653a:	6a 00                	push   $0x0
8010653c:	68 db 00 00 00       	push   $0xdb
80106541:	e9 97 f2 ff ff       	jmp    801057dd <alltraps>

80106546 <vector220>:
80106546:	6a 00                	push   $0x0
80106548:	68 dc 00 00 00       	push   $0xdc
8010654d:	e9 8b f2 ff ff       	jmp    801057dd <alltraps>

80106552 <vector221>:
80106552:	6a 00                	push   $0x0
80106554:	68 dd 00 00 00       	push   $0xdd
80106559:	e9 7f f2 ff ff       	jmp    801057dd <alltraps>

8010655e <vector222>:
8010655e:	6a 00                	push   $0x0
80106560:	68 de 00 00 00       	push   $0xde
80106565:	e9 73 f2 ff ff       	jmp    801057dd <alltraps>

8010656a <vector223>:
8010656a:	6a 00                	push   $0x0
8010656c:	68 df 00 00 00       	push   $0xdf
80106571:	e9 67 f2 ff ff       	jmp    801057dd <alltraps>

80106576 <vector224>:
80106576:	6a 00                	push   $0x0
80106578:	68 e0 00 00 00       	push   $0xe0
8010657d:	e9 5b f2 ff ff       	jmp    801057dd <alltraps>

80106582 <vector225>:
80106582:	6a 00                	push   $0x0
80106584:	68 e1 00 00 00       	push   $0xe1
80106589:	e9 4f f2 ff ff       	jmp    801057dd <alltraps>

8010658e <vector226>:
8010658e:	6a 00                	push   $0x0
80106590:	68 e2 00 00 00       	push   $0xe2
80106595:	e9 43 f2 ff ff       	jmp    801057dd <alltraps>

8010659a <vector227>:
8010659a:	6a 00                	push   $0x0
8010659c:	68 e3 00 00 00       	push   $0xe3
801065a1:	e9 37 f2 ff ff       	jmp    801057dd <alltraps>

801065a6 <vector228>:
801065a6:	6a 00                	push   $0x0
801065a8:	68 e4 00 00 00       	push   $0xe4
801065ad:	e9 2b f2 ff ff       	jmp    801057dd <alltraps>

801065b2 <vector229>:
801065b2:	6a 00                	push   $0x0
801065b4:	68 e5 00 00 00       	push   $0xe5
801065b9:	e9 1f f2 ff ff       	jmp    801057dd <alltraps>

801065be <vector230>:
801065be:	6a 00                	push   $0x0
801065c0:	68 e6 00 00 00       	push   $0xe6
801065c5:	e9 13 f2 ff ff       	jmp    801057dd <alltraps>

801065ca <vector231>:
801065ca:	6a 00                	push   $0x0
801065cc:	68 e7 00 00 00       	push   $0xe7
801065d1:	e9 07 f2 ff ff       	jmp    801057dd <alltraps>

801065d6 <vector232>:
801065d6:	6a 00                	push   $0x0
801065d8:	68 e8 00 00 00       	push   $0xe8
801065dd:	e9 fb f1 ff ff       	jmp    801057dd <alltraps>

801065e2 <vector233>:
801065e2:	6a 00                	push   $0x0
801065e4:	68 e9 00 00 00       	push   $0xe9
801065e9:	e9 ef f1 ff ff       	jmp    801057dd <alltraps>

801065ee <vector234>:
801065ee:	6a 00                	push   $0x0
801065f0:	68 ea 00 00 00       	push   $0xea
801065f5:	e9 e3 f1 ff ff       	jmp    801057dd <alltraps>

801065fa <vector235>:
801065fa:	6a 00                	push   $0x0
801065fc:	68 eb 00 00 00       	push   $0xeb
80106601:	e9 d7 f1 ff ff       	jmp    801057dd <alltraps>

80106606 <vector236>:
80106606:	6a 00                	push   $0x0
80106608:	68 ec 00 00 00       	push   $0xec
8010660d:	e9 cb f1 ff ff       	jmp    801057dd <alltraps>

80106612 <vector237>:
80106612:	6a 00                	push   $0x0
80106614:	68 ed 00 00 00       	push   $0xed
80106619:	e9 bf f1 ff ff       	jmp    801057dd <alltraps>

8010661e <vector238>:
8010661e:	6a 00                	push   $0x0
80106620:	68 ee 00 00 00       	push   $0xee
80106625:	e9 b3 f1 ff ff       	jmp    801057dd <alltraps>

8010662a <vector239>:
8010662a:	6a 00                	push   $0x0
8010662c:	68 ef 00 00 00       	push   $0xef
80106631:	e9 a7 f1 ff ff       	jmp    801057dd <alltraps>

80106636 <vector240>:
80106636:	6a 00                	push   $0x0
80106638:	68 f0 00 00 00       	push   $0xf0
8010663d:	e9 9b f1 ff ff       	jmp    801057dd <alltraps>

80106642 <vector241>:
80106642:	6a 00                	push   $0x0
80106644:	68 f1 00 00 00       	push   $0xf1
80106649:	e9 8f f1 ff ff       	jmp    801057dd <alltraps>

8010664e <vector242>:
8010664e:	6a 00                	push   $0x0
80106650:	68 f2 00 00 00       	push   $0xf2
80106655:	e9 83 f1 ff ff       	jmp    801057dd <alltraps>

8010665a <vector243>:
8010665a:	6a 00                	push   $0x0
8010665c:	68 f3 00 00 00       	push   $0xf3
80106661:	e9 77 f1 ff ff       	jmp    801057dd <alltraps>

80106666 <vector244>:
80106666:	6a 00                	push   $0x0
80106668:	68 f4 00 00 00       	push   $0xf4
8010666d:	e9 6b f1 ff ff       	jmp    801057dd <alltraps>

80106672 <vector245>:
80106672:	6a 00                	push   $0x0
80106674:	68 f5 00 00 00       	push   $0xf5
80106679:	e9 5f f1 ff ff       	jmp    801057dd <alltraps>

8010667e <vector246>:
8010667e:	6a 00                	push   $0x0
80106680:	68 f6 00 00 00       	push   $0xf6
80106685:	e9 53 f1 ff ff       	jmp    801057dd <alltraps>

8010668a <vector247>:
8010668a:	6a 00                	push   $0x0
8010668c:	68 f7 00 00 00       	push   $0xf7
80106691:	e9 47 f1 ff ff       	jmp    801057dd <alltraps>

80106696 <vector248>:
80106696:	6a 00                	push   $0x0
80106698:	68 f8 00 00 00       	push   $0xf8
8010669d:	e9 3b f1 ff ff       	jmp    801057dd <alltraps>

801066a2 <vector249>:
801066a2:	6a 00                	push   $0x0
801066a4:	68 f9 00 00 00       	push   $0xf9
801066a9:	e9 2f f1 ff ff       	jmp    801057dd <alltraps>

801066ae <vector250>:
801066ae:	6a 00                	push   $0x0
801066b0:	68 fa 00 00 00       	push   $0xfa
801066b5:	e9 23 f1 ff ff       	jmp    801057dd <alltraps>

801066ba <vector251>:
801066ba:	6a 00                	push   $0x0
801066bc:	68 fb 00 00 00       	push   $0xfb
801066c1:	e9 17 f1 ff ff       	jmp    801057dd <alltraps>

801066c6 <vector252>:
801066c6:	6a 00                	push   $0x0
801066c8:	68 fc 00 00 00       	push   $0xfc
801066cd:	e9 0b f1 ff ff       	jmp    801057dd <alltraps>

801066d2 <vector253>:
801066d2:	6a 00                	push   $0x0
801066d4:	68 fd 00 00 00       	push   $0xfd
801066d9:	e9 ff f0 ff ff       	jmp    801057dd <alltraps>

801066de <vector254>:
801066de:	6a 00                	push   $0x0
801066e0:	68 fe 00 00 00       	push   $0xfe
801066e5:	e9 f3 f0 ff ff       	jmp    801057dd <alltraps>

801066ea <vector255>:
801066ea:	6a 00                	push   $0x0
801066ec:	68 ff 00 00 00       	push   $0xff
801066f1:	e9 e7 f0 ff ff       	jmp    801057dd <alltraps>
801066f6:	66 90                	xchg   %ax,%ax
801066f8:	66 90                	xchg   %ax,%ax
801066fa:	66 90                	xchg   %ax,%ax
801066fc:	66 90                	xchg   %ax,%ax
801066fe:	66 90                	xchg   %ax,%ax

80106700 <walkpgdir>:
80106700:	55                   	push   %ebp
80106701:	89 e5                	mov    %esp,%ebp
80106703:	57                   	push   %edi
80106704:	56                   	push   %esi
80106705:	89 d6                	mov    %edx,%esi
80106707:	c1 ea 16             	shr    $0x16,%edx
8010670a:	53                   	push   %ebx
8010670b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
8010670e:	83 ec 1c             	sub    $0x1c,%esp
80106711:	8b 1f                	mov    (%edi),%ebx
80106713:	f6 c3 01             	test   $0x1,%bl
80106716:	74 28                	je     80106740 <walkpgdir+0x40>
80106718:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010671e:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80106724:	c1 ee 0a             	shr    $0xa,%esi
80106727:	83 c4 1c             	add    $0x1c,%esp
8010672a:	89 f2                	mov    %esi,%edx
8010672c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106732:	8d 04 13             	lea    (%ebx,%edx,1),%eax
80106735:	5b                   	pop    %ebx
80106736:	5e                   	pop    %esi
80106737:	5f                   	pop    %edi
80106738:	5d                   	pop    %ebp
80106739:	c3                   	ret    
8010673a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106740:	85 c9                	test   %ecx,%ecx
80106742:	74 34                	je     80106778 <walkpgdir+0x78>
80106744:	e8 57 bd ff ff       	call   801024a0 <kalloc>
80106749:	85 c0                	test   %eax,%eax
8010674b:	89 c3                	mov    %eax,%ebx
8010674d:	74 29                	je     80106778 <walkpgdir+0x78>
8010674f:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106756:	00 
80106757:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010675e:	00 
8010675f:	89 04 24             	mov    %eax,(%esp)
80106762:	e8 29 de ff ff       	call   80104590 <memset>
80106767:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010676d:	83 c8 07             	or     $0x7,%eax
80106770:	89 07                	mov    %eax,(%edi)
80106772:	eb b0                	jmp    80106724 <walkpgdir+0x24>
80106774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106778:	83 c4 1c             	add    $0x1c,%esp
8010677b:	31 c0                	xor    %eax,%eax
8010677d:	5b                   	pop    %ebx
8010677e:	5e                   	pop    %esi
8010677f:	5f                   	pop    %edi
80106780:	5d                   	pop    %ebp
80106781:	c3                   	ret    
80106782:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106790 <mappages>:
80106790:	55                   	push   %ebp
80106791:	89 e5                	mov    %esp,%ebp
80106793:	57                   	push   %edi
80106794:	56                   	push   %esi
80106795:	53                   	push   %ebx
80106796:	89 d3                	mov    %edx,%ebx
80106798:	83 ec 1c             	sub    $0x1c,%esp
8010679b:	8b 7d 08             	mov    0x8(%ebp),%edi
8010679e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801067a4:	89 45 e0             	mov    %eax,-0x20(%ebp)
801067a7:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801067ab:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801067ae:	83 4d 0c 01          	orl    $0x1,0xc(%ebp)
801067b2:	81 65 e4 00 f0 ff ff 	andl   $0xfffff000,-0x1c(%ebp)
801067b9:	29 df                	sub    %ebx,%edi
801067bb:	eb 18                	jmp    801067d5 <mappages+0x45>
801067bd:	8d 76 00             	lea    0x0(%esi),%esi
801067c0:	f6 00 01             	testb  $0x1,(%eax)
801067c3:	75 3d                	jne    80106802 <mappages+0x72>
801067c5:	0b 75 0c             	or     0xc(%ebp),%esi
801067c8:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
801067cb:	89 30                	mov    %esi,(%eax)
801067cd:	74 29                	je     801067f8 <mappages+0x68>
801067cf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801067d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801067d8:	b9 01 00 00 00       	mov    $0x1,%ecx
801067dd:	89 da                	mov    %ebx,%edx
801067df:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
801067e2:	e8 19 ff ff ff       	call   80106700 <walkpgdir>
801067e7:	85 c0                	test   %eax,%eax
801067e9:	75 d5                	jne    801067c0 <mappages+0x30>
801067eb:	83 c4 1c             	add    $0x1c,%esp
801067ee:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801067f3:	5b                   	pop    %ebx
801067f4:	5e                   	pop    %esi
801067f5:	5f                   	pop    %edi
801067f6:	5d                   	pop    %ebp
801067f7:	c3                   	ret    
801067f8:	83 c4 1c             	add    $0x1c,%esp
801067fb:	31 c0                	xor    %eax,%eax
801067fd:	5b                   	pop    %ebx
801067fe:	5e                   	pop    %esi
801067ff:	5f                   	pop    %edi
80106800:	5d                   	pop    %ebp
80106801:	c3                   	ret    
80106802:	c7 04 24 54 79 10 80 	movl   $0x80107954,(%esp)
80106809:	e8 52 9b ff ff       	call   80100360 <panic>
8010680e:	66 90                	xchg   %ax,%ax

80106810 <deallocuvm.part.0>:
80106810:	55                   	push   %ebp
80106811:	89 e5                	mov    %esp,%ebp
80106813:	57                   	push   %edi
80106814:	89 c7                	mov    %eax,%edi
80106816:	56                   	push   %esi
80106817:	89 d6                	mov    %edx,%esi
80106819:	53                   	push   %ebx
8010681a:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106820:	83 ec 1c             	sub    $0x1c,%esp
80106823:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106829:	39 d3                	cmp    %edx,%ebx
8010682b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010682e:	72 3b                	jb     8010686b <deallocuvm.part.0+0x5b>
80106830:	eb 5e                	jmp    80106890 <deallocuvm.part.0+0x80>
80106832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106838:	8b 10                	mov    (%eax),%edx
8010683a:	f6 c2 01             	test   $0x1,%dl
8010683d:	74 22                	je     80106861 <deallocuvm.part.0+0x51>
8010683f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106845:	74 54                	je     8010689b <deallocuvm.part.0+0x8b>
80106847:	81 c2 00 00 00 80    	add    $0x80000000,%edx
8010684d:	89 14 24             	mov    %edx,(%esp)
80106850:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106853:	e8 98 ba ff ff       	call   801022f0 <kfree>
80106858:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010685b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80106861:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106867:	39 f3                	cmp    %esi,%ebx
80106869:	73 25                	jae    80106890 <deallocuvm.part.0+0x80>
8010686b:	31 c9                	xor    %ecx,%ecx
8010686d:	89 da                	mov    %ebx,%edx
8010686f:	89 f8                	mov    %edi,%eax
80106871:	e8 8a fe ff ff       	call   80106700 <walkpgdir>
80106876:	85 c0                	test   %eax,%eax
80106878:	75 be                	jne    80106838 <deallocuvm.part.0+0x28>
8010687a:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106880:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
80106886:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010688c:	39 f3                	cmp    %esi,%ebx
8010688e:	72 db                	jb     8010686b <deallocuvm.part.0+0x5b>
80106890:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106893:	83 c4 1c             	add    $0x1c,%esp
80106896:	5b                   	pop    %ebx
80106897:	5e                   	pop    %esi
80106898:	5f                   	pop    %edi
80106899:	5d                   	pop    %ebp
8010689a:	c3                   	ret    
8010689b:	c7 04 24 86 72 10 80 	movl   $0x80107286,(%esp)
801068a2:	e8 b9 9a ff ff       	call   80100360 <panic>
801068a7:	89 f6                	mov    %esi,%esi
801068a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801068b0 <seginit>:
801068b0:	55                   	push   %ebp
801068b1:	89 e5                	mov    %esp,%ebp
801068b3:	83 ec 18             	sub    $0x18,%esp
801068b6:	e8 15 ce ff ff       	call   801036d0 <cpuid>
801068bb:	31 c9                	xor    %ecx,%ecx
801068bd:	ba ff ff ff ff       	mov    $0xffffffff,%edx
801068c2:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801068c8:	05 80 27 11 80       	add    $0x80112780,%eax
801068cd:	66 89 50 78          	mov    %dx,0x78(%eax)
801068d1:	ba ff ff ff ff       	mov    $0xffffffff,%edx
801068d6:	83 c0 70             	add    $0x70,%eax
801068d9:	66 89 48 0a          	mov    %cx,0xa(%eax)
801068dd:	31 c9                	xor    %ecx,%ecx
801068df:	66 89 50 10          	mov    %dx,0x10(%eax)
801068e3:	ba ff ff ff ff       	mov    $0xffffffff,%edx
801068e8:	66 89 48 12          	mov    %cx,0x12(%eax)
801068ec:	31 c9                	xor    %ecx,%ecx
801068ee:	66 89 50 18          	mov    %dx,0x18(%eax)
801068f2:	ba ff ff ff ff       	mov    $0xffffffff,%edx
801068f7:	66 89 48 1a          	mov    %cx,0x1a(%eax)
801068fb:	31 c9                	xor    %ecx,%ecx
801068fd:	c6 40 0d 9a          	movb   $0x9a,0xd(%eax)
80106901:	c6 40 0e cf          	movb   $0xcf,0xe(%eax)
80106905:	c6 40 15 92          	movb   $0x92,0x15(%eax)
80106909:	c6 40 16 cf          	movb   $0xcf,0x16(%eax)
8010690d:	c6 40 1d fa          	movb   $0xfa,0x1d(%eax)
80106911:	c6 40 1e cf          	movb   $0xcf,0x1e(%eax)
80106915:	c6 40 25 f2          	movb   $0xf2,0x25(%eax)
80106919:	c6 40 26 cf          	movb   $0xcf,0x26(%eax)
8010691d:	66 89 50 20          	mov    %dx,0x20(%eax)
80106921:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106926:	c6 40 0c 00          	movb   $0x0,0xc(%eax)
8010692a:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
8010692e:	c6 40 14 00          	movb   $0x0,0x14(%eax)
80106932:	c6 40 17 00          	movb   $0x0,0x17(%eax)
80106936:	c6 40 1c 00          	movb   $0x0,0x1c(%eax)
8010693a:	c6 40 1f 00          	movb   $0x0,0x1f(%eax)
8010693e:	66 89 48 22          	mov    %cx,0x22(%eax)
80106942:	c6 40 24 00          	movb   $0x0,0x24(%eax)
80106946:	c6 40 27 00          	movb   $0x0,0x27(%eax)
8010694a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
8010694e:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
80106952:	c1 e8 10             	shr    $0x10,%eax
80106955:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
80106959:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010695c:	0f 01 10             	lgdtl  (%eax)
8010695f:	c9                   	leave  
80106960:	c3                   	ret    
80106961:	eb 0d                	jmp    80106970 <switchkvm>
80106963:	90                   	nop
80106964:	90                   	nop
80106965:	90                   	nop
80106966:	90                   	nop
80106967:	90                   	nop
80106968:	90                   	nop
80106969:	90                   	nop
8010696a:	90                   	nop
8010696b:	90                   	nop
8010696c:	90                   	nop
8010696d:	90                   	nop
8010696e:	90                   	nop
8010696f:	90                   	nop

80106970 <switchkvm>:
80106970:	a1 a4 58 11 80       	mov    0x801158a4,%eax
80106975:	55                   	push   %ebp
80106976:	89 e5                	mov    %esp,%ebp
80106978:	05 00 00 00 80       	add    $0x80000000,%eax
8010697d:	0f 22 d8             	mov    %eax,%cr3
80106980:	5d                   	pop    %ebp
80106981:	c3                   	ret    
80106982:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106990 <switchuvm>:
80106990:	55                   	push   %ebp
80106991:	89 e5                	mov    %esp,%ebp
80106993:	57                   	push   %edi
80106994:	56                   	push   %esi
80106995:	53                   	push   %ebx
80106996:	83 ec 1c             	sub    $0x1c,%esp
80106999:	8b 75 08             	mov    0x8(%ebp),%esi
8010699c:	85 f6                	test   %esi,%esi
8010699e:	0f 84 cd 00 00 00    	je     80106a71 <switchuvm+0xe1>
801069a4:	8b 46 08             	mov    0x8(%esi),%eax
801069a7:	85 c0                	test   %eax,%eax
801069a9:	0f 84 da 00 00 00    	je     80106a89 <switchuvm+0xf9>
801069af:	8b 7e 04             	mov    0x4(%esi),%edi
801069b2:	85 ff                	test   %edi,%edi
801069b4:	0f 84 c3 00 00 00    	je     80106a7d <switchuvm+0xed>
801069ba:	e8 21 da ff ff       	call   801043e0 <pushcli>
801069bf:	e8 8c cc ff ff       	call   80103650 <mycpu>
801069c4:	89 c3                	mov    %eax,%ebx
801069c6:	e8 85 cc ff ff       	call   80103650 <mycpu>
801069cb:	89 c7                	mov    %eax,%edi
801069cd:	e8 7e cc ff ff       	call   80103650 <mycpu>
801069d2:	83 c7 08             	add    $0x8,%edi
801069d5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801069d8:	e8 73 cc ff ff       	call   80103650 <mycpu>
801069dd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801069e0:	ba 67 00 00 00       	mov    $0x67,%edx
801069e5:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
801069ec:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
801069f3:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
801069fa:	83 c1 08             	add    $0x8,%ecx
801069fd:	c1 e9 10             	shr    $0x10,%ecx
80106a00:	83 c0 08             	add    $0x8,%eax
80106a03:	c1 e8 18             	shr    $0x18,%eax
80106a06:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106a0c:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106a13:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106a19:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106a1e:	e8 2d cc ff ff       	call   80103650 <mycpu>
80106a23:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
80106a2a:	e8 21 cc ff ff       	call   80103650 <mycpu>
80106a2f:	b9 10 00 00 00       	mov    $0x10,%ecx
80106a34:	66 89 48 10          	mov    %cx,0x10(%eax)
80106a38:	e8 13 cc ff ff       	call   80103650 <mycpu>
80106a3d:	8b 56 08             	mov    0x8(%esi),%edx
80106a40:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106a46:	89 48 0c             	mov    %ecx,0xc(%eax)
80106a49:	e8 02 cc ff ff       	call   80103650 <mycpu>
80106a4e:	66 89 58 6e          	mov    %bx,0x6e(%eax)
80106a52:	b8 28 00 00 00       	mov    $0x28,%eax
80106a57:	0f 00 d8             	ltr    %ax
80106a5a:	8b 46 04             	mov    0x4(%esi),%eax
80106a5d:	05 00 00 00 80       	add    $0x80000000,%eax
80106a62:	0f 22 d8             	mov    %eax,%cr3
80106a65:	83 c4 1c             	add    $0x1c,%esp
80106a68:	5b                   	pop    %ebx
80106a69:	5e                   	pop    %esi
80106a6a:	5f                   	pop    %edi
80106a6b:	5d                   	pop    %ebp
80106a6c:	e9 af d9 ff ff       	jmp    80104420 <popcli>
80106a71:	c7 04 24 5a 79 10 80 	movl   $0x8010795a,(%esp)
80106a78:	e8 e3 98 ff ff       	call   80100360 <panic>
80106a7d:	c7 04 24 85 79 10 80 	movl   $0x80107985,(%esp)
80106a84:	e8 d7 98 ff ff       	call   80100360 <panic>
80106a89:	c7 04 24 70 79 10 80 	movl   $0x80107970,(%esp)
80106a90:	e8 cb 98 ff ff       	call   80100360 <panic>
80106a95:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106aa0 <inituvm>:
80106aa0:	55                   	push   %ebp
80106aa1:	89 e5                	mov    %esp,%ebp
80106aa3:	57                   	push   %edi
80106aa4:	56                   	push   %esi
80106aa5:	53                   	push   %ebx
80106aa6:	83 ec 1c             	sub    $0x1c,%esp
80106aa9:	8b 75 10             	mov    0x10(%ebp),%esi
80106aac:	8b 45 08             	mov    0x8(%ebp),%eax
80106aaf:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106ab2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106ab8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106abb:	77 54                	ja     80106b11 <inituvm+0x71>
80106abd:	e8 de b9 ff ff       	call   801024a0 <kalloc>
80106ac2:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106ac9:	00 
80106aca:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106ad1:	00 
80106ad2:	89 c3                	mov    %eax,%ebx
80106ad4:	89 04 24             	mov    %eax,(%esp)
80106ad7:	e8 b4 da ff ff       	call   80104590 <memset>
80106adc:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106ae2:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106ae7:	89 04 24             	mov    %eax,(%esp)
80106aea:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106aed:	31 d2                	xor    %edx,%edx
80106aef:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106af6:	00 
80106af7:	e8 94 fc ff ff       	call   80106790 <mappages>
80106afc:	89 75 10             	mov    %esi,0x10(%ebp)
80106aff:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106b02:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106b05:	83 c4 1c             	add    $0x1c,%esp
80106b08:	5b                   	pop    %ebx
80106b09:	5e                   	pop    %esi
80106b0a:	5f                   	pop    %edi
80106b0b:	5d                   	pop    %ebp
80106b0c:	e9 1f db ff ff       	jmp    80104630 <memmove>
80106b11:	c7 04 24 99 79 10 80 	movl   $0x80107999,(%esp)
80106b18:	e8 43 98 ff ff       	call   80100360 <panic>
80106b1d:	8d 76 00             	lea    0x0(%esi),%esi

80106b20 <loaduvm>:
80106b20:	55                   	push   %ebp
80106b21:	89 e5                	mov    %esp,%ebp
80106b23:	57                   	push   %edi
80106b24:	56                   	push   %esi
80106b25:	53                   	push   %ebx
80106b26:	83 ec 1c             	sub    $0x1c,%esp
80106b29:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106b30:	0f 85 98 00 00 00    	jne    80106bce <loaduvm+0xae>
80106b36:	8b 75 18             	mov    0x18(%ebp),%esi
80106b39:	31 db                	xor    %ebx,%ebx
80106b3b:	85 f6                	test   %esi,%esi
80106b3d:	75 1a                	jne    80106b59 <loaduvm+0x39>
80106b3f:	eb 77                	jmp    80106bb8 <loaduvm+0x98>
80106b41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b48:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b4e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106b54:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106b57:	76 5f                	jbe    80106bb8 <loaduvm+0x98>
80106b59:	8b 55 0c             	mov    0xc(%ebp),%edx
80106b5c:	31 c9                	xor    %ecx,%ecx
80106b5e:	8b 45 08             	mov    0x8(%ebp),%eax
80106b61:	01 da                	add    %ebx,%edx
80106b63:	e8 98 fb ff ff       	call   80106700 <walkpgdir>
80106b68:	85 c0                	test   %eax,%eax
80106b6a:	74 56                	je     80106bc2 <loaduvm+0xa2>
80106b6c:	8b 00                	mov    (%eax),%eax
80106b6e:	bf 00 10 00 00       	mov    $0x1000,%edi
80106b73:	8b 4d 14             	mov    0x14(%ebp),%ecx
80106b76:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106b7b:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
80106b81:	0f 42 fe             	cmovb  %esi,%edi
80106b84:	05 00 00 00 80       	add    $0x80000000,%eax
80106b89:	89 44 24 04          	mov    %eax,0x4(%esp)
80106b8d:	8b 45 10             	mov    0x10(%ebp),%eax
80106b90:	01 d9                	add    %ebx,%ecx
80106b92:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80106b96:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106b9a:	89 04 24             	mov    %eax,(%esp)
80106b9d:	e8 be ad ff ff       	call   80101960 <readi>
80106ba2:	39 f8                	cmp    %edi,%eax
80106ba4:	74 a2                	je     80106b48 <loaduvm+0x28>
80106ba6:	83 c4 1c             	add    $0x1c,%esp
80106ba9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106bae:	5b                   	pop    %ebx
80106baf:	5e                   	pop    %esi
80106bb0:	5f                   	pop    %edi
80106bb1:	5d                   	pop    %ebp
80106bb2:	c3                   	ret    
80106bb3:	90                   	nop
80106bb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106bb8:	83 c4 1c             	add    $0x1c,%esp
80106bbb:	31 c0                	xor    %eax,%eax
80106bbd:	5b                   	pop    %ebx
80106bbe:	5e                   	pop    %esi
80106bbf:	5f                   	pop    %edi
80106bc0:	5d                   	pop    %ebp
80106bc1:	c3                   	ret    
80106bc2:	c7 04 24 b3 79 10 80 	movl   $0x801079b3,(%esp)
80106bc9:	e8 92 97 ff ff       	call   80100360 <panic>
80106bce:	c7 04 24 54 7a 10 80 	movl   $0x80107a54,(%esp)
80106bd5:	e8 86 97 ff ff       	call   80100360 <panic>
80106bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106be0 <allocuvm>:
80106be0:	55                   	push   %ebp
80106be1:	89 e5                	mov    %esp,%ebp
80106be3:	57                   	push   %edi
80106be4:	56                   	push   %esi
80106be5:	53                   	push   %ebx
80106be6:	83 ec 1c             	sub    $0x1c,%esp
80106be9:	8b 7d 10             	mov    0x10(%ebp),%edi
80106bec:	85 ff                	test   %edi,%edi
80106bee:	0f 88 7e 00 00 00    	js     80106c72 <allocuvm+0x92>
80106bf4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106bf7:	8b 45 0c             	mov    0xc(%ebp),%eax
80106bfa:	72 78                	jb     80106c74 <allocuvm+0x94>
80106bfc:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106c02:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106c08:	39 df                	cmp    %ebx,%edi
80106c0a:	77 4a                	ja     80106c56 <allocuvm+0x76>
80106c0c:	eb 72                	jmp    80106c80 <allocuvm+0xa0>
80106c0e:	66 90                	xchg   %ax,%ax
80106c10:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106c17:	00 
80106c18:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106c1f:	00 
80106c20:	89 04 24             	mov    %eax,(%esp)
80106c23:	e8 68 d9 ff ff       	call   80104590 <memset>
80106c28:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106c2e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c33:	89 04 24             	mov    %eax,(%esp)
80106c36:	8b 45 08             	mov    0x8(%ebp),%eax
80106c39:	89 da                	mov    %ebx,%edx
80106c3b:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106c42:	00 
80106c43:	e8 48 fb ff ff       	call   80106790 <mappages>
80106c48:	85 c0                	test   %eax,%eax
80106c4a:	78 44                	js     80106c90 <allocuvm+0xb0>
80106c4c:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c52:	39 df                	cmp    %ebx,%edi
80106c54:	76 2a                	jbe    80106c80 <allocuvm+0xa0>
80106c56:	e8 45 b8 ff ff       	call   801024a0 <kalloc>
80106c5b:	85 c0                	test   %eax,%eax
80106c5d:	89 c6                	mov    %eax,%esi
80106c5f:	75 af                	jne    80106c10 <allocuvm+0x30>
80106c61:	c7 04 24 d1 79 10 80 	movl   $0x801079d1,(%esp)
80106c68:	e8 e3 99 ff ff       	call   80100650 <cprintf>
80106c6d:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106c70:	77 48                	ja     80106cba <allocuvm+0xda>
80106c72:	31 c0                	xor    %eax,%eax
80106c74:	83 c4 1c             	add    $0x1c,%esp
80106c77:	5b                   	pop    %ebx
80106c78:	5e                   	pop    %esi
80106c79:	5f                   	pop    %edi
80106c7a:	5d                   	pop    %ebp
80106c7b:	c3                   	ret    
80106c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106c80:	83 c4 1c             	add    $0x1c,%esp
80106c83:	89 f8                	mov    %edi,%eax
80106c85:	5b                   	pop    %ebx
80106c86:	5e                   	pop    %esi
80106c87:	5f                   	pop    %edi
80106c88:	5d                   	pop    %ebp
80106c89:	c3                   	ret    
80106c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106c90:	c7 04 24 e9 79 10 80 	movl   $0x801079e9,(%esp)
80106c97:	e8 b4 99 ff ff       	call   80100650 <cprintf>
80106c9c:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106c9f:	76 0d                	jbe    80106cae <allocuvm+0xce>
80106ca1:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106ca4:	89 fa                	mov    %edi,%edx
80106ca6:	8b 45 08             	mov    0x8(%ebp),%eax
80106ca9:	e8 62 fb ff ff       	call   80106810 <deallocuvm.part.0>
80106cae:	89 34 24             	mov    %esi,(%esp)
80106cb1:	e8 3a b6 ff ff       	call   801022f0 <kfree>
80106cb6:	31 c0                	xor    %eax,%eax
80106cb8:	eb ba                	jmp    80106c74 <allocuvm+0x94>
80106cba:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106cbd:	89 fa                	mov    %edi,%edx
80106cbf:	8b 45 08             	mov    0x8(%ebp),%eax
80106cc2:	e8 49 fb ff ff       	call   80106810 <deallocuvm.part.0>
80106cc7:	31 c0                	xor    %eax,%eax
80106cc9:	eb a9                	jmp    80106c74 <allocuvm+0x94>
80106ccb:	90                   	nop
80106ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106cd0 <deallocuvm>:
80106cd0:	55                   	push   %ebp
80106cd1:	89 e5                	mov    %esp,%ebp
80106cd3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106cd6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106cd9:	8b 45 08             	mov    0x8(%ebp),%eax
80106cdc:	39 d1                	cmp    %edx,%ecx
80106cde:	73 08                	jae    80106ce8 <deallocuvm+0x18>
80106ce0:	5d                   	pop    %ebp
80106ce1:	e9 2a fb ff ff       	jmp    80106810 <deallocuvm.part.0>
80106ce6:	66 90                	xchg   %ax,%ax
80106ce8:	89 d0                	mov    %edx,%eax
80106cea:	5d                   	pop    %ebp
80106ceb:	c3                   	ret    
80106cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106cf0 <freevm>:
80106cf0:	55                   	push   %ebp
80106cf1:	89 e5                	mov    %esp,%ebp
80106cf3:	56                   	push   %esi
80106cf4:	53                   	push   %ebx
80106cf5:	83 ec 10             	sub    $0x10,%esp
80106cf8:	8b 75 08             	mov    0x8(%ebp),%esi
80106cfb:	85 f6                	test   %esi,%esi
80106cfd:	74 59                	je     80106d58 <freevm+0x68>
80106cff:	31 c9                	xor    %ecx,%ecx
80106d01:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106d06:	89 f0                	mov    %esi,%eax
80106d08:	31 db                	xor    %ebx,%ebx
80106d0a:	e8 01 fb ff ff       	call   80106810 <deallocuvm.part.0>
80106d0f:	eb 12                	jmp    80106d23 <freevm+0x33>
80106d11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d18:	83 c3 01             	add    $0x1,%ebx
80106d1b:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80106d21:	74 27                	je     80106d4a <freevm+0x5a>
80106d23:	8b 14 9e             	mov    (%esi,%ebx,4),%edx
80106d26:	f6 c2 01             	test   $0x1,%dl
80106d29:	74 ed                	je     80106d18 <freevm+0x28>
80106d2b:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106d31:	83 c3 01             	add    $0x1,%ebx
80106d34:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106d3a:	89 14 24             	mov    %edx,(%esp)
80106d3d:	e8 ae b5 ff ff       	call   801022f0 <kfree>
80106d42:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80106d48:	75 d9                	jne    80106d23 <freevm+0x33>
80106d4a:	89 75 08             	mov    %esi,0x8(%ebp)
80106d4d:	83 c4 10             	add    $0x10,%esp
80106d50:	5b                   	pop    %ebx
80106d51:	5e                   	pop    %esi
80106d52:	5d                   	pop    %ebp
80106d53:	e9 98 b5 ff ff       	jmp    801022f0 <kfree>
80106d58:	c7 04 24 05 7a 10 80 	movl   $0x80107a05,(%esp)
80106d5f:	e8 fc 95 ff ff       	call   80100360 <panic>
80106d64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106d6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106d70 <setupkvm>:
80106d70:	55                   	push   %ebp
80106d71:	89 e5                	mov    %esp,%ebp
80106d73:	56                   	push   %esi
80106d74:	53                   	push   %ebx
80106d75:	83 ec 10             	sub    $0x10,%esp
80106d78:	e8 23 b7 ff ff       	call   801024a0 <kalloc>
80106d7d:	85 c0                	test   %eax,%eax
80106d7f:	89 c6                	mov    %eax,%esi
80106d81:	74 6d                	je     80106df0 <setupkvm+0x80>
80106d83:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106d8a:	00 
80106d8b:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
80106d90:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106d97:	00 
80106d98:	89 04 24             	mov    %eax,(%esp)
80106d9b:	e8 f0 d7 ff ff       	call   80104590 <memset>
80106da0:	8b 53 0c             	mov    0xc(%ebx),%edx
80106da3:	8b 43 04             	mov    0x4(%ebx),%eax
80106da6:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106da9:	89 54 24 04          	mov    %edx,0x4(%esp)
80106dad:	8b 13                	mov    (%ebx),%edx
80106daf:	89 04 24             	mov    %eax,(%esp)
80106db2:	29 c1                	sub    %eax,%ecx
80106db4:	89 f0                	mov    %esi,%eax
80106db6:	e8 d5 f9 ff ff       	call   80106790 <mappages>
80106dbb:	85 c0                	test   %eax,%eax
80106dbd:	78 19                	js     80106dd8 <setupkvm+0x68>
80106dbf:	83 c3 10             	add    $0x10,%ebx
80106dc2:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106dc8:	72 d6                	jb     80106da0 <setupkvm+0x30>
80106dca:	89 f0                	mov    %esi,%eax
80106dcc:	83 c4 10             	add    $0x10,%esp
80106dcf:	5b                   	pop    %ebx
80106dd0:	5e                   	pop    %esi
80106dd1:	5d                   	pop    %ebp
80106dd2:	c3                   	ret    
80106dd3:	90                   	nop
80106dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106dd8:	89 34 24             	mov    %esi,(%esp)
80106ddb:	e8 10 ff ff ff       	call   80106cf0 <freevm>
80106de0:	83 c4 10             	add    $0x10,%esp
80106de3:	31 c0                	xor    %eax,%eax
80106de5:	5b                   	pop    %ebx
80106de6:	5e                   	pop    %esi
80106de7:	5d                   	pop    %ebp
80106de8:	c3                   	ret    
80106de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106df0:	31 c0                	xor    %eax,%eax
80106df2:	eb d8                	jmp    80106dcc <setupkvm+0x5c>
80106df4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106dfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106e00 <kvmalloc>:
80106e00:	55                   	push   %ebp
80106e01:	89 e5                	mov    %esp,%ebp
80106e03:	83 ec 08             	sub    $0x8,%esp
80106e06:	e8 65 ff ff ff       	call   80106d70 <setupkvm>
80106e0b:	a3 a4 58 11 80       	mov    %eax,0x801158a4
80106e10:	05 00 00 00 80       	add    $0x80000000,%eax
80106e15:	0f 22 d8             	mov    %eax,%cr3
80106e18:	c9                   	leave  
80106e19:	c3                   	ret    
80106e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106e20 <clearpteu>:
80106e20:	55                   	push   %ebp
80106e21:	31 c9                	xor    %ecx,%ecx
80106e23:	89 e5                	mov    %esp,%ebp
80106e25:	83 ec 18             	sub    $0x18,%esp
80106e28:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e2b:	8b 45 08             	mov    0x8(%ebp),%eax
80106e2e:	e8 cd f8 ff ff       	call   80106700 <walkpgdir>
80106e33:	85 c0                	test   %eax,%eax
80106e35:	74 05                	je     80106e3c <clearpteu+0x1c>
80106e37:	83 20 fb             	andl   $0xfffffffb,(%eax)
80106e3a:	c9                   	leave  
80106e3b:	c3                   	ret    
80106e3c:	c7 04 24 16 7a 10 80 	movl   $0x80107a16,(%esp)
80106e43:	e8 18 95 ff ff       	call   80100360 <panic>
80106e48:	90                   	nop
80106e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106e50 <copyuvm>:
80106e50:	55                   	push   %ebp
80106e51:	89 e5                	mov    %esp,%ebp
80106e53:	57                   	push   %edi
80106e54:	56                   	push   %esi
80106e55:	53                   	push   %ebx
80106e56:	83 ec 2c             	sub    $0x2c,%esp
80106e59:	e8 12 ff ff ff       	call   80106d70 <setupkvm>
80106e5e:	85 c0                	test   %eax,%eax
80106e60:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106e63:	0f 84 b9 00 00 00    	je     80106f22 <copyuvm+0xd2>
80106e69:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e6c:	85 c0                	test   %eax,%eax
80106e6e:	0f 84 94 00 00 00    	je     80106f08 <copyuvm+0xb8>
80106e74:	31 ff                	xor    %edi,%edi
80106e76:	eb 48                	jmp    80106ec0 <copyuvm+0x70>
80106e78:	81 c6 00 00 00 80    	add    $0x80000000,%esi
80106e7e:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106e85:	00 
80106e86:	89 74 24 04          	mov    %esi,0x4(%esp)
80106e8a:	89 04 24             	mov    %eax,(%esp)
80106e8d:	e8 9e d7 ff ff       	call   80104630 <memmove>
80106e92:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e95:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e9a:	89 fa                	mov    %edi,%edx
80106e9c:	89 44 24 04          	mov    %eax,0x4(%esp)
80106ea0:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106ea6:	89 04 24             	mov    %eax,(%esp)
80106ea9:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106eac:	e8 df f8 ff ff       	call   80106790 <mappages>
80106eb1:	85 c0                	test   %eax,%eax
80106eb3:	78 63                	js     80106f18 <copyuvm+0xc8>
80106eb5:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106ebb:	39 7d 0c             	cmp    %edi,0xc(%ebp)
80106ebe:	76 48                	jbe    80106f08 <copyuvm+0xb8>
80106ec0:	8b 45 08             	mov    0x8(%ebp),%eax
80106ec3:	31 c9                	xor    %ecx,%ecx
80106ec5:	89 fa                	mov    %edi,%edx
80106ec7:	e8 34 f8 ff ff       	call   80106700 <walkpgdir>
80106ecc:	85 c0                	test   %eax,%eax
80106ece:	74 62                	je     80106f32 <copyuvm+0xe2>
80106ed0:	8b 00                	mov    (%eax),%eax
80106ed2:	a8 01                	test   $0x1,%al
80106ed4:	74 50                	je     80106f26 <copyuvm+0xd6>
80106ed6:	89 c6                	mov    %eax,%esi
80106ed8:	25 ff 0f 00 00       	and    $0xfff,%eax
80106edd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106ee0:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80106ee6:	e8 b5 b5 ff ff       	call   801024a0 <kalloc>
80106eeb:	85 c0                	test   %eax,%eax
80106eed:	89 c3                	mov    %eax,%ebx
80106eef:	75 87                	jne    80106e78 <copyuvm+0x28>
80106ef1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106ef4:	89 04 24             	mov    %eax,(%esp)
80106ef7:	e8 f4 fd ff ff       	call   80106cf0 <freevm>
80106efc:	31 c0                	xor    %eax,%eax
80106efe:	83 c4 2c             	add    $0x2c,%esp
80106f01:	5b                   	pop    %ebx
80106f02:	5e                   	pop    %esi
80106f03:	5f                   	pop    %edi
80106f04:	5d                   	pop    %ebp
80106f05:	c3                   	ret    
80106f06:	66 90                	xchg   %ax,%ax
80106f08:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f0b:	83 c4 2c             	add    $0x2c,%esp
80106f0e:	5b                   	pop    %ebx
80106f0f:	5e                   	pop    %esi
80106f10:	5f                   	pop    %edi
80106f11:	5d                   	pop    %ebp
80106f12:	c3                   	ret    
80106f13:	90                   	nop
80106f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106f18:	89 1c 24             	mov    %ebx,(%esp)
80106f1b:	e8 d0 b3 ff ff       	call   801022f0 <kfree>
80106f20:	eb cf                	jmp    80106ef1 <copyuvm+0xa1>
80106f22:	31 c0                	xor    %eax,%eax
80106f24:	eb d8                	jmp    80106efe <copyuvm+0xae>
80106f26:	c7 04 24 3a 7a 10 80 	movl   $0x80107a3a,(%esp)
80106f2d:	e8 2e 94 ff ff       	call   80100360 <panic>
80106f32:	c7 04 24 20 7a 10 80 	movl   $0x80107a20,(%esp)
80106f39:	e8 22 94 ff ff       	call   80100360 <panic>
80106f3e:	66 90                	xchg   %ax,%ax

80106f40 <uva2ka>:
80106f40:	55                   	push   %ebp
80106f41:	31 c9                	xor    %ecx,%ecx
80106f43:	89 e5                	mov    %esp,%ebp
80106f45:	83 ec 08             	sub    $0x8,%esp
80106f48:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f4b:	8b 45 08             	mov    0x8(%ebp),%eax
80106f4e:	e8 ad f7 ff ff       	call   80106700 <walkpgdir>
80106f53:	8b 00                	mov    (%eax),%eax
80106f55:	89 c2                	mov    %eax,%edx
80106f57:	83 e2 05             	and    $0x5,%edx
80106f5a:	83 fa 05             	cmp    $0x5,%edx
80106f5d:	75 11                	jne    80106f70 <uva2ka+0x30>
80106f5f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106f64:	05 00 00 00 80       	add    $0x80000000,%eax
80106f69:	c9                   	leave  
80106f6a:	c3                   	ret    
80106f6b:	90                   	nop
80106f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106f70:	31 c0                	xor    %eax,%eax
80106f72:	c9                   	leave  
80106f73:	c3                   	ret    
80106f74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106f80 <copyout>:
80106f80:	55                   	push   %ebp
80106f81:	89 e5                	mov    %esp,%ebp
80106f83:	57                   	push   %edi
80106f84:	56                   	push   %esi
80106f85:	53                   	push   %ebx
80106f86:	83 ec 1c             	sub    $0x1c,%esp
80106f89:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106f8c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106f8f:	8b 7d 10             	mov    0x10(%ebp),%edi
80106f92:	85 db                	test   %ebx,%ebx
80106f94:	75 3a                	jne    80106fd0 <copyout+0x50>
80106f96:	eb 68                	jmp    80107000 <copyout+0x80>
80106f98:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106f9b:	89 f2                	mov    %esi,%edx
80106f9d:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106fa1:	29 ca                	sub    %ecx,%edx
80106fa3:	81 c2 00 10 00 00    	add    $0x1000,%edx
80106fa9:	39 da                	cmp    %ebx,%edx
80106fab:	0f 47 d3             	cmova  %ebx,%edx
80106fae:	29 f1                	sub    %esi,%ecx
80106fb0:	01 c8                	add    %ecx,%eax
80106fb2:	89 54 24 08          	mov    %edx,0x8(%esp)
80106fb6:	89 04 24             	mov    %eax,(%esp)
80106fb9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106fbc:	e8 6f d6 ff ff       	call   80104630 <memmove>
80106fc1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106fc4:	8d 8e 00 10 00 00    	lea    0x1000(%esi),%ecx
80106fca:	01 d7                	add    %edx,%edi
80106fcc:	29 d3                	sub    %edx,%ebx
80106fce:	74 30                	je     80107000 <copyout+0x80>
80106fd0:	8b 45 08             	mov    0x8(%ebp),%eax
80106fd3:	89 ce                	mov    %ecx,%esi
80106fd5:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80106fdb:	89 74 24 04          	mov    %esi,0x4(%esp)
80106fdf:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80106fe2:	89 04 24             	mov    %eax,(%esp)
80106fe5:	e8 56 ff ff ff       	call   80106f40 <uva2ka>
80106fea:	85 c0                	test   %eax,%eax
80106fec:	75 aa                	jne    80106f98 <copyout+0x18>
80106fee:	83 c4 1c             	add    $0x1c,%esp
80106ff1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106ff6:	5b                   	pop    %ebx
80106ff7:	5e                   	pop    %esi
80106ff8:	5f                   	pop    %edi
80106ff9:	5d                   	pop    %ebp
80106ffa:	c3                   	ret    
80106ffb:	90                   	nop
80106ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107000:	83 c4 1c             	add    $0x1c,%esp
80107003:	31 c0                	xor    %eax,%eax
80107005:	5b                   	pop    %ebx
80107006:	5e                   	pop    %esi
80107007:	5f                   	pop    %edi
80107008:	5d                   	pop    %ebp
80107009:	c3                   	ret    
